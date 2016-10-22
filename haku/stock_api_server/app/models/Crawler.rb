require 'nokogiri'
require 'watir'
require 'watir-webdriver'

class Crawler
  def self.crawl
    browser = Watir::Browser.new :phantomjs
    browser.goto 'http://stock.wearn.com/qua.asp'
    doc = Nokogiri::HTML.parse(browser.html)

    doc
      .css('.stockalllist > table > tbody > tr')
      .map { |tr|
        datas = tr.css('td')

        if datas[1].nil? then nil else {
          :stock_code => datas[1] && datas[1].text,
          :stock_name => datas[2] && datas[2].text.strip,
          :opening_price => datas[3] && datas[3].text.strip,
          :highest_price => datas[4] && datas[4].text.strip,
          :lowest_price => datas[5] && datas[5].text.strip,
          :closing_ytd => datas[6] && datas[6].text.strip,
          :closing_today => datas[7] && datas[7].text.strip,
          :trading_volume => datas[8] && datas[8].text.strip,
          :change => datas[9] && datas[9].text.strip[/[0-9|\.]+/],
          :change_limit => datas[10] && datas[10].text.strip
        } end
      }
      .compact
      .first 50
  end

  def self.crawlToDB
    rows = Crawler.crawl

    Turnover.delete_today

    rows.each do |row|
      Turnover.save_new_turnovers(row)
    end

    rows
  end
end
