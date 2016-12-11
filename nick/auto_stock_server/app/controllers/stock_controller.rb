class StockController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  # default page
  def index
    
    # default filter is all of the today's turnover 
    opt = {
      :start_date => DateTime.now,
      :end_date => DateTime.now
    }
    @turnovers = turnover_select(opt)
  end

  # given data filter by date or stock_number 
  def create
    opt = {
      # given option
    }
    @turnovers = turnover_select(opt)
    render :template => "index"
  end 

  # update today's turnover in database
  def update

    # update db manually
    Crawler.crawl_data_to_db()
    
    # return json
    render :json => Crawler.get_daily_data()
  end

  private

  # filter turnover by given options     
  def turnover_select(opt)
    start_date = opt[:start_date]== nil ? DateTime.now.beginning_of_day : opt[:start_date]
    end_date = opt[:end_date]== nil ? DateTime.now.end_of_day : opt[:end_date]
    company = opt[:company]
    result = []   # filter result  

    # filter without stock_number
    if (!company) 

      # default is all of the company
      result = Turnover.where(
        :timestamps => start_date.beginning_of_day..end_date.end_of_day
      )
    else 
      result = company.map do |stock_number|

        # return one and the only row of daily turnover
        Turnover.where(
          :timestamps => start_date.beginning_of_day..end_date.end_of_day,
          :stock_number => stock_number
        )
      end
      result = result.flatten
    end
    
    # prevent from returning result which contain nil not an array 
    result = result[0] ? result : []

    # return Array which caontain all the query data 
    return result
  end 
end
