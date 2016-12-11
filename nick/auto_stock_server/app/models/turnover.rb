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
end
