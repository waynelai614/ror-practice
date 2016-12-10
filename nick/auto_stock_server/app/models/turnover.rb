class Turnover 
  include Mongoid::Document
  include Mongoid::Timestamps

  # schema
  field :stock_number, type: Integer 
  field :stock_name, type: String
  field :stock_company_hyperlink, type: String 
  field :stock_opening_price, type: Float
  field :stock_highest_price, type: Float
  field :stock_floor_price, type: Float
  field :stock_closing_yesterday, type: Float 
  field :stock_closing_today, type: Float
  field :stock_volumn, type: Integer
  field :stock_change, type: Float
  field :stock_quote_change, type: String
  field :timestamps, type: Time, default: -> { Time.now}


  # def self.delete_today
  #   now = Time.new
  #   tmr = now + (60 * 60 * 24)

  #   Turnover.where(
  #     :timestamp.gte => "#{now.year}-#{now.month}-#{now.day}",
  #     :timestamp.lt => "#{tmr.year}-#{tmr.month}-#{tmr.day}"
  #   ).delete
  # end

  # save the new row of turnover 
  # def self.new_turnover(row)
  #   t = Turnover.new
  #   t.stock_number = row[:stock_number] 
  #   t.stock_name = row[:stock_name]
  #   t.stock_company_hyperlink = row[:stock_company_hyperlink] 
  #   t.stock_opening_price = row[:stock_opening_price]
  #   t.stock_highest_price = row[:stock_highest_price]
  #   t.stock_floor_price = row[:stock_floor_price]
  #   t.stock_closing_yesterday = row[:stock_closing_yesterday] 
  #   t.stock_closing_today = row[:stock_closing_today]
  #   t.stock_volumn = row[:stock_volumn]
  #   t.stock_change = row[:stock_change]
  #   t.stock_quote_change = row[:stock_quote_change]

  #   # save without timestamps
  #   t.save
  # end

end
