class TopController < ApplicationController
  def index
    @turnovers = Turnover.all
    respond_to do |format|
      format.html
      format.json { render :json => @turnovers }
    end
  end

  def crawl
    @rows = Turnover.all
  end
end
