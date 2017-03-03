# Stock controller
class StockController < ApplicationController
  # /stock #GET, return all datas
  def index
    @turnovers =
      if params[:code]
        Turnover.where(stock_code: params[:code])
      else
        Turnover.all
      end
    render json: @turnovers, status: :ok
  end

  # /stocl/crawl #POST update today's turnovers
  def crawl
    @turnovers = Crawler.crawl_data_to_db
    render json: { status: 'success', create_time: Time.now, data: @turnovers }, status: :ok
  end
end
