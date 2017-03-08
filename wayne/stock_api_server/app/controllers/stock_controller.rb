# Stock controller
class StockController < ApplicationController
  # #GET, get the turnovers by codes and date condition
  # /stock, return today's turnovers
  # /stock?codes=1314,2023, query multi codes with comma-separated string
  # /stock?date=yyyyMMdd, query by date string format
  # /stock?codes=1314,2023&date=yyyyMMdd, query by codes and date
  def index
    @turnovers =
      if params[:codes] && params[:date]
        Turnover
          .find_by_code_and_date(
            split_str_by_comma(params[:codes]),
            validate_date(params[:date])
          )
      elsif params[:codes]
        Turnover.find_by_code(split_str_by_comma(params[:codes]))
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

  # split and remove whitespace
  def split_str_by_comma(str)
    str.split(',').map(&:strip)
  end

  def validate_date(date)
    date.to_time
  rescue ArgumentError
    # date format doesn't match
    Time.now
  end
end
