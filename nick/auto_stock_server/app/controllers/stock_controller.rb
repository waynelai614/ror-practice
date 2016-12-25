class StockController < ApplicationController

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
      :start_date => params[:start_date],
      :end_date => params[:end_date],
      :stock_number => params[:stock_number]
    }

    # argument validation
    opt = arguValidation(opt)

    # searching data
    @turnovers = turnover_select(opt)

    # retrun json object
    render :json => @turnovers.to_json
  end 

  # update today's turnover in database
  def update

    # update db manually
    Crawler.crawl_data_to_db()
    
    # return json
    render :json => Crawler.get_daily_data()
  end

  private

  # argument validation
  def arguValidation(opt)

    # start_date
    # if isn't DateTime or String type, return now
    begin
      unless (opt[:start_date].instance_of? String) || (opt[:start_date].instance_of? DateTime)
        raise ArgumentError
      end 
    rescue ArgumentError
       opt[:start_date] = nil
    end 

    # end_date
    # if isn't DateTime or String type, return now
    begin
      unless (opt[:end_date].instance_of? String) || (opt[:end_date].instance_of? DateTime)
        raise ArgumentError
      end 
    rescue ArgumentError
       opt[:end_date] = nil
    end 

    # # stock numner
    # # if isn't Array type, return nil
    begin
      unless opt[:stock_number].instance_of? Array
        raise ArgumentError
        
      end 
    rescue ArgumentError
       opt[:stock_number] = nil
    end 

    

    return opt
  end 

  # filter turnover by given options     
  def turnover_select(opt)
    start_date = opt[:start_date] ? opt[:start_date] : DateTime.now.beginning_of_day
    end_date = opt[:end_date] ? opt[:end_date] : DateTime.now.end_of_day
    company = opt[:stock_number]

    # if date are string type
    if start_date.instance_of? String
      start_date = DateTime.parse(start_date)
    end 

    if end_date.instance_of? String 
       end_date = DateTime.parse(end_date)
    end
    
   

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