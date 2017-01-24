class StockController < ApplicationController
  # start_date :String(YYYYMMDD) - 8 bit string
  # end_date :String(YYYYMMDD) - 8 bit string
  # stock_number :Array

  # /stock #GET, render page filtered by given condition
  def index
    # @turnovers are the result of querying
    # return erb without web server
    @turnovers = launch
  end

  # /stock #POST, return json data filtered by given condition
  def create
    # @turnovers are the result of querying
    @turnovers = launch

    # retrun json object
    render json: @turnovers.to_json
  end

  # /stock/data #POST, update today's turnover in database manually
  def data
    # update db manually
    Crawler.crawl_data_to_db

    # return json
    render json: Crawler.get_daily_data
  end

  # given condition and query data
  # return result of querying
  def launch
    # get request parameters
    request = {
      start_date: params[:start_date],
      end_date: params[:end_date],
      stock_number: params[:stock_number]
    }

    # verify request parameters
    opt = argument_init(request)

    # retrun selecting data from DB
    turnover_select(opt)
  end

  # data format doesn't match expected,
  # raise Exception and return deafult value
  def argument_init(opt)
    payload = {}
    payload[:start_date] = start_date_verify(opt[:start_date])
    payload[:end_date] = end_date_verify(opt[:end_date])
    payload[:stock_number] = stock_number_verify(opt[:stock_number])
    payload
  end

  private

  # return ISODate Obj
  def start_date_verify(date)
    raise ArgumentError if date.nil?

    year = date.slice(0, 4).to_i  # year is 4-bit string
    month = date.slice(4, 2).to_i # month is 4-bit string
    day = date.slice(6, 2).to_i # date is 4-bit string

    Time.new(year, month, day)
  rescue

    # date format doesn't match
    Time.now.beginning_of_day
  end

  def end_date_verify(date)
    raise ArgumentError if date.nil?

    year = date.slice(0, 4).to_i  # year is 4-bit integer
    month = date.slice(4, 2).to_i # month is 2-bit integer
    day = date.slice(6, 2).to_i # date is 2-bit integer

    Time.new(year, month, day)
  rescue

    # date format doesn't match
    Time.now.end_of_day
  end

  def stock_number_verify(stock_number)
    raise ArgumentError if stock_number.nil?

    # if stock numner cannot transfer to Array type, return an empty Array
    stock_number
      .to_s
      .strip
      .tr('[]', '')
      .split(',')
      .map do |s|
        s.to_i unless s.to_i.zero?
      end
      .compact
  rescue ArgumentError
    # return a empty Array
    return []
  end

  # filter turnover by given options
  def turnover_select(opt)
    start_date, end_date, company = opt.values_at(:start_date, :end_date, :stock_number)
    # filter without stock_number
    result =
      if company.empty?
        # default is all of the company
        Turnover.where(
          timestamps: start_date.beginning_of_day..end_date.end_of_day
        )
      else
        company.flat_map do |stock_number|
          # return one and the only row of daily turnover
          result = Turnover.where(
            timestamps: start_date.beginning_of_day..end_date.end_of_day,
            stock_number: stock_number
          )
        end
      end
    # return Array which caontain all the query data
    # if query nothing, return an empty array
    result = result.empty? ? [] : result
  end
end
