module Api
  module V1
    class StocksController < ApplicationController
      SUCCESS_MSG = 'SUCCESS'
      ERROR_MSG = 'ERROR'

      # GET /api/v1/stocks, today's turnovers
      def index
        turnovers = Crawler.sort_today
        if turnovers.empty?
          render json: {
            status: ERROR_MSG,
            message: 'Something wrong with data parsing'
          }, status: 400
        else
          render json: {
            status: SUCCESS_MSG,
            message: 'Loaded today\'s turnovers',
            data: turnovers
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
          }, status: 400
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
