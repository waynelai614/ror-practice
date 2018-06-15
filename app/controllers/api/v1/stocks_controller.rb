module Api
  module V1
    class StocksController < ApplicationController
      SUCCESS_MSG = 'SUCCESS'
      ERROR_MSG = 'ERROR'

      # GET /api/v1/stocks, today's turnovers
      def index
        turnover_today = Crawler.turnover_today
        turnover_date = Crawler.turnover_date
        if turnover_today.empty?
          render json: {
            status: ERROR_MSG,
            message: 'Something wrong with data parsing'
          }, status: :bad_request
        else
          render json: {
            status: SUCCESS_MSG,
            message: 'Loaded turnovers',
            today: turnover_today,
            date: turnover_date
        }, status: :ok
        end
      end

      # GET /api/v1/stocks/sort, get data by params
      # e.g /api/v1/stocks/sort?code=XXXX&date=YYYYMMDD
      def sort
        if Crawler.sort_data(params[:code], params[:date]).empty?
          render json: {
            status: ERROR_MSG,
            message: 'No match data'
          }, status: :bad_request
        else
          render json: {
            status: SUCCESS_MSG,
            message: 'Loaded turnovers by stock code and date',
            data: Crawler.sort_data(params[:code], params[:date])
          }, status: :ok
        end
      end
    end
  end
end
