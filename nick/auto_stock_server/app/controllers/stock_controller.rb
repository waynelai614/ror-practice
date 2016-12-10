class StockController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  # default page
  def index
    @turnovers = Turnover.all
  end



  # create data
  def create
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

      # puts "wtf man"
      # puts turnover[:stock_volumn]
    end     

    
    puts turnovers.length

    # go back to index page
    # redirect_to :action => :index
  end
end
