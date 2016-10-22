class TurnoversController < ApplicationController
  def index
    render :json => Turnover.where(
      :timestamp => DateTime.now.beginning_of_day..DateTime.now.end_of_day
    )
  end

  def show
    render :json => Turnover.where(
      :timestamp => DateTime.now.beginning_of_day..DateTime.now.end_of_day
    )
  end
end
