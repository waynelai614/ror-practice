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

  # /stock/export.json?sort={column_name}&direction={asc|desc} #GET get turnovers (JSON) and order by column
  # /stock/export.xlsx?sort={column_name}&direction={asc|desc} #GET get turnovers (xlsx) and order by column
  def export
    @turnovers = Turnover.order(sort_column + ' ' + sort_direction)
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

  # return the exist column name, default: 'created_at'
  def sort_column
    Turnover.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  # return the sort direction, default: 'asc'
  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
