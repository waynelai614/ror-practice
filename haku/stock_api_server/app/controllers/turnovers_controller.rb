class TurnoversController < ApplicationController
  def index
    render json: Turnover.all
  end

  def show
    render json: Turnover.all
  end
end
