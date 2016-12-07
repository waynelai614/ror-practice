class StockController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  # default page
  def index
    @turnovers = Turnover.all
  end



  # update data
  def update
    # parse html
    html = open("http://stock.wearn.com/qua.asp").read
    charset = Nokogiri::HTML(html).meta_encoding
    html.force_encoding(charset)
    html.encode!("utf-8", :undef => :replace, :replace => "?", :invalid => :replace)
    doc = Nokogiri::HTML.parse html

    # parse node
    node = doc.css('.stockalllistbg1, .stockalllistbg2')
    [0, 1, 2, 3, 4].each do |index|

      # select sibling elements
      company = node[index].css('>td')

      #009900 => down
      #ec008c => up
      font = company[9].css('font')
      if font.length > 0

        change = font[0]["color"].index('ec008c')? company[9].text.strip.strip[/[0-9|\.]+/].to_f : -company[9].text.strip.strip[/[0-9|\.]+/].to_f
      else
        change = 0
      end

      turnoverInfo = {
        :stock_number => company[1].text.strip,
        :stock_name => company[2].text.strip,
        :stock_opening_price => company[3].text.strip.to_f,
        :stock_highest_price => company[4].text.strip.to_f,
        :stock_floor_price => company[5].text.strip.to_f,
        :stock_closing_yesterday => company[6].text.strip.to_f,
        :stock_closing_today => company[7].text.strip.to_f,
        :stock_volumn => company[8].text.strip,
        :stock_change => change,
        :stock_quote_change => company[10].text.strip
      }

      # save to server
      @newTurnover = Turnover.new(turnoverInfo)
      @newTurnover.save
    end

    # go back to index page
    # redirect_to :action => :index
  end
end
