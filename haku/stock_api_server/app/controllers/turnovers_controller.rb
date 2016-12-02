class TurnoversController < ApplicationController
  def index
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"

    puts 'hello world'

    if params[:date] && params[:code]
      render_by_date_and_code
    elsif params[:date]
      render_by_date
    elsif params[:code]
      render_by_code
    else
      render_default
    end
  end

  def render_default
    render :json => Turnover.where(
      :timestamp => DateTime.now.beginning_of_day..DateTime.now.end_of_day
    )
  end

  def render_by_date
    start_date = params[:date].to_time
    end_date = start_date + (60 * 60 * 24)

    render :json => Turnover.where(
      :timestamp => start_date..end_date
    )
  end

  def render_by_code
    render :json => Turnover.where(
      :stock_code => params[:code]
    )
  end

  def render_by_date_and_code
    start_date = params[:date].to_time
    end_date = start_date + (60 * 60 * 24)

    render :json => Turnover.where(
      :timestamp => start_date..end_date
    ).where(
      :stock_code => params[:code]
    )
  end
end
