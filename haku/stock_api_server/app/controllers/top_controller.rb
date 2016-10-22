class TopController < ApplicationController
  def index
  end

  def crawl
    @rows = Turnover.all
  end
end
