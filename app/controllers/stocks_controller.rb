class StocksController < ApplicationController
  def index
    @data = Crawler.get_data
    @turnovers = Crawler.data_to_db
  end
end
