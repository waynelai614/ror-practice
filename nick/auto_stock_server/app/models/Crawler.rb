class Crawler 
  require 'nokogiri'
  require 'open-uri'
 
  # the count of getting and setting in DB
  DATA_COUNT = 50

  def self.crawl_data_to_db

    # delete all today's data in DB
    delete_repeat()

    # insert new data 
    update_daily_data()

  end 

  def self.get_daily_data(count = DATA_COUNT)
     # parse html
    html = open("http://stock.wearn.com/qua.asp").read
    charset = "big5"
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

    # retrun all daily turnovers 
    return turnovers.first(count)
  end 

  # the following are private class method ======================
  # delete repeated data in DB 
  def self.delete_repeat 
    Turnover.where(
      :timestamps => DateTime.now.beginning_of_day..DateTime.now.end_of_day,
    ).delete
  end 

  # update today's turnover in database
  def self.update_daily_data

    # get all turnovers
    turnovers = get_daily_data()
      
    # save to database
    turnovers.first(DATA_COUNT).each do |turnover|
      newTurnover = Turnover.new(turnover)
      newTurnover.save
    end     
  end 

  private_class_method :delete_repeat, :update_daily_data




end 