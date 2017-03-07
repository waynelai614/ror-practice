# Stock controller
class StockController < ApplicationController
  # /stock #GET, return all datas
  def index
    @turnovers =
      if params[:code] && params[:date]
        Turnover.find_by_code_and_date(params[:code], validate_date(params[:date]))
      elsif params[:code]
        Turnover.find_by_code(params[:code])
      elsif params[:date]
        Turnover.find_by_date(validate_date(params[:date]))
      else
        Turnover.find_by_date(Time.now)
      end
    render json: @turnovers, status: :ok
  end

  # /stock/export.json?sort={column_name}&direction={asc|desc} #GET get turnovers (JSON) and order by column
  # /stock/export.xlsx?sort={column_name}&direction={asc|desc} #GET get turnovers (xlsx) and order by column
  def export
    @turnovers = Turnover.sort_by(params[:sort], params[:direction])
    respond_to do |format|
      format.json { render json: @turnovers }
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="turnovers.xlsx"' }
    end
  end

  # /stock/crawl #POST update today's turnovers
  def crawl
    @turnovers = Crawler.crawl_data_to_db
    render json: { status: 'success', create_time: Time.now, data: @turnovers }, status: :ok
  end

  private

  def validate_date(date)
    date.to_time
  rescue ArgumentError
    # date format doesn't match
    Time.now
  end
end
