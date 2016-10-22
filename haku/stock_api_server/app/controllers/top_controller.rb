class TopController < ApplicationController
  def index
  end

  def crawl
    @rows = Crawler.crawlToDB
  end
end
