# Stock controller
class StockController < ApplicationController
def index
  render json: { status: 'SUCCESS', message: 'Test success!' }, status: :ok
end
end
