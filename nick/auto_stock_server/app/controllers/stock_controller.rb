class StockController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  # default page
  def index
    
    # default filter is all of the today's turnover 
    opt = {
      :start_date => DateTime.now,
      :end_date => DateTime.now
    }
    @turnovers = turnover_select(opt)
  end

  # given data filter by date or stock_number 
  def create
    opt = {
      # given option
    }
    @turnovers = turnover_select(opt)
    render :template => "index"
  end 

  # update today's turnover in database
  def update

    # parse html
    html = open("http://stock.wearn.com/qua.asp").read
    charset = Nokogiri::HTML(html).meta_encoding
    html.force_encoding(charset)
    html.encode!("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)
    doc = Nokogiri::HTML.parse html

    # parse node
    node = doc.css('.stockalllistbg1, .stockalllistbg2')
    turnovers = node.map do |tr|

      # select sibling elements
      company = tr.css('>td')

      # parse the company href in element a
      href = company[2].css('> a')[0]['href']

      # determine the value of change positive or negative by font color.
      # 009900 : green => price down
      # ec008c : red => price up
      font = company[9].css('font')

      # length is greater than 0 that means the change doesn't equal to 0
      if font.length > 0
        change = font[0]["color"].index('ec008c') ? company[9].text.strip.strip[/[0-9|\.]+/].to_f : -company[9].text.strip.strip[/[0-9|\.]+/].to_f
      else
        change = 0
      end

      {
        :stock_number => company[1].text.strip,
        :stock_name => company[2].text.strip,
        :stock_company_hyperlink => href.strip,
        :stock_opening_price => company[3].text.strip.to_f,
        :stock_highest_price => company[4].text.strip.to_f,
        :stock_floor_price => company[5].text.strip.to_f,
        :stock_closing_yesterday => company[6].text.strip.to_f,
        :stock_closing_today => company[7].text.strip.to_f,
        :stock_volumn => company[8].text.strip.tr(',', '').to_i,
        :stock_change => change,
        :stock_quote_change => company[10].text.strip
      }

    end 
      
    # save to database
    turnovers.first(50).each do |turnover|
      newTurnover = Turnover.new(turnover)
      newTurnover.save
    end     

    # render api data 
    render :nothing => true 

  end

  private

  # filter turnover by given options     
  def turnover_select(opt)
    start_date = opt[:start_date]== nil ? DateTime.now.beginning_of_day : opt[:start_date]
    end_date = opt[:end_date]== nil ? DateTime.now.end_of_day : opt[:end_date]
    company = opt[:company]
    result = []   # filter result  

    # filter without stock_number
    if (!company) 

      # default is all of the company
      result = Turnover.where(
        :timestamps => start_date.beginning_of_day..end_date.end_of_day
      )
    else 
      result = company.map do |stock_number|

        # return one and the only row of daily turnover
        Turnover.where(
          :timestamps => start_date.beginning_of_day..end_date.end_of_day,
          :stock_number => stock_number
        )
      end
      result = result.flatten
    end
    
    # prevent from returning result which contain nil not an array 
    result = result[0] ? result : []

    # return Array which caontain all the query data 
    return result
  end 
end
