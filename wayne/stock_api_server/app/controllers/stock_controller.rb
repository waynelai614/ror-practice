# Stock controller
class StockController < ApplicationController
  # /stock.json?... #GET get turnovers (JSON)
  # /stock.xlsx?... #GET get turnovers (xlsx)
  # /stock.json?codes={1314,2023}&date={yyyyMMdd}&sort={column_name}&direction={asc|desc}
  # All params are optional.
  # Default query: today's turnovers
  # Default sorting: order by id asc`
  # -------
  # Example
  # /stock.json, return today's turnovers
  # /stock.json?codes=1314,2023, query multi codes with comma-separated string
  # /stock.json?date=yyyyMMdd, query by date string format
  # /stock.json?codes=1314,2023&date=yyyyMMdd, query by codes and date
  # /stock.json?sort=stock_volume&direction=desc, query today's turnovers and sort by params
  def index
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1728000'

    @turnovers = sort_array_of_obj(filter_turnovers, params[:sort], params[:direction])

    respond_to do |format|
      format.json { render json: @turnovers, status: :ok }
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="turnovers.xlsx"' }
    end
  end

  # /stock/date #GET return the avaliable date string YYYY-MM-DD (the date has data)
  def date
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = '1728000'

    render json: Turnover.find_distinct_date, status: :ok
  end

  # /stock/crawl #POST update today's turnovers
  def crawl
    @turnovers = Crawler.crawl_data_to_db
    render json: { status: 'success', create_time: Time.now, data: @turnovers }, status: :ok
  end

  private

  def filter_turnovers
    if params[:codes] && params[:date]
      Turnover
        .find_by_code_and_date(
          split_str_by_comma(params[:codes]),
          date_verify(params[:date])
        )
    elsif params[:codes]
      Turnover.find_by_code(split_str_by_comma(params[:codes]))
    elsif params[:date]
      Turnover.find_by_date(date_verify(params[:date]))
    else
      Turnover.find_by_date(Time.now)
    end
  end

  # split and remove whitespace
  def split_str_by_comma(str)
    str.split(',').map(&:strip)
  end

  def date_verify(date)
    date.to_time
  rescue ArgumentError
    # date format doesn't match
    Time.now
  end

  # return the exist column name, default: 'id'
  def sort_column_verify(column)
    Turnover.column_names.include?(column) ? column : 'id'
  end

  def sort_array_of_obj(arr, attr, direction)
    # return the sort direction, default: 'asc'
    sort_direction = %w(asc desc).include?(direction) ? direction : 'asc'
    sorted_arr = arr.sort { |a, b| a[attr] <=> b[attr] }
    sort_direction == 'asc' ? sorted_arr : sorted_arr.reverse
  end
end
