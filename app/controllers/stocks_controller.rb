class StocksController < ApplicationController
  def index
    @data = Crawler.daily_data
    # get table rows
    # @rows = []
    # doc.css('.stockalllist table tr[class^="stockalllistbg"]').each do |th|
    #   @rows << th.text
    # end

    # get table headers
    # doc = Nokogiri::HTML(open('https://stock.wearn.com/qua.asp'))
    # @table_headers = []
    # doc.css('.stockalllist table th').each do |th|
    #   @table_headers << th.text
    # end
  end
end
