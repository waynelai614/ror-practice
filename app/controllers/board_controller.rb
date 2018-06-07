class BoardController < ApplicationController
  def index
    Crawler.data_to_db
  end
end
