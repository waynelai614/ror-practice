class Crawler
  require 'nokogiri'
  require 'open-uri'
  class StockConstants
    # get top 50 turnover
    DATA_COUNT = 50
  end

  class << self
    def daily_data
      doc = html_parse
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
        stock_code = cells[1].text.strip
        stock_name = cells[2].text.strip
        stock_company_url = company_url.strip
        stock_opening_price = cells[3].text.strip.to_f
        stock_highest_price = cells[4].text.strip.to_f
        stock_lowest_price = cells[5].text.strip.to_f
        stock_closing_yesterday = cells[6].text.strip.to_f
        stock_closing_today = cells[7].text.strip.to_f
        stock_volumn = cells[8].text.strip.to_f
        stock_change = change
        stock_quote_change = cells[12].text.strip
      end
      stocks.first(StockConstants::DATA_COUNT)
    end

    private

    # Fetch and parse HTML document
    def html_parse
      parse_url = open('https://stock.wearn.com/qua.asp').read
      parse_url.force_encoding('big5')
      parse_url.encode!('utf-8', undef: :replace, replace: '?', invalid: :replace)
      Nokogiri::HTML(parse_url)
    end
  end
end
