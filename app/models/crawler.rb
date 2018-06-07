class Crawler
  require 'nokogiri'
  require 'open-uri'

  class << self

    # get top 50 turnover
    DATA_COUNT = 50
    # parse url
    PARSE_URL = 
      open('https://stock.wearn.com/qua.asp')
      .read.force_encoding('big5')
      .encode!('utf-8', undef: :replace, replace: '?', invalid: :replace)

    def get_data
      doc = parse_source
      table = doc.css('.stockalllistbg2, .stockalllistbg1')
      stocks = table.map do |tr|
        cells = tr.css('td')
        # get stock_company_url
        company_url = cells[2].css('a')[0]['href']
        # get stock_change
        fonts = cells[9].css('font')
        change =
          if !fonts.empty? && fonts[0]['color'].index('#ec008c')
            cells[9].text.strip[/[0-9|\.]+/].to_f
          elsif !fonts.empty? && fonts[0]['color'].index('#009900')
            -cells[9].text.strip[/[0-9|\.]+/].to_f
          else
            0
          end
        { stock_code: cells[1].text.strip,
          stock_name: cells[2].text.strip,
          stock_company_url: company_url.strip,
          stock_opening_price: cells[3].text.strip.to_f,
          stock_highest_price: cells[4].text.strip.to_f,
          stock_lowest_price: cells[5].text.strip.to_f,
          stock_closing_yesterday: cells[6].text.strip.to_f,
          stock_closing_today: cells[7].text.strip.to_f,
          stock_volumn: cells[8].text.strip.to_f,
          stock_change: change,
          stock_quote_change: cells[12].text.partition('%').first.strip }
      end
      stocks.first(DATA_COUNT)
    end

    # save data to database
    # it might set many crob jobs per day
    # delete old data first, then insert new data
    def data_to_db
      delete_old_data
      update_data(get_data)
    end

    # sort date by stock code, date or both.
    def sort_data(code, date)
      if code.nil?
        Turnover.where(
          created_at: date.to_time.beginning_of_day..date.to_time.end_of_day
        )
      elsif date.nil?
        Turnover.where(
          stock_code: code
        )
      else
        Turnover.where(
          stock_code: code,
          created_at: Time.now.beginning_of_day..Time.now.end_of_day
        )
      end
    end


    private

    # Fetch and parse HTML document
    def parse_source
      Nokogiri::HTML(PARSE_URL)
    end

    # data_to_db: insert new turnover to database
    def update_data(stocks_data)
      stocks_data.each do |stock|
        Turnover.new(stock).save
      end
    end

    # data_to_db: delete old data in database
    def delete_old_data
      Turnover.where(
        created_at: Time.now.beginning_of_day..Time.now.end_of_day
      ).destroy_all
    end
  end
end
