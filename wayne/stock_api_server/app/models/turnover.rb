class Turnover < ActiveRecord::Base
  attr_accessible :stock_code, :stock_name, :stock_company_uri, :stock_opening_price, :stock_highest_price, :stock_lowest_price, :stock_closing_yesterday, :stock_closing_today, :stock_volume, :stock_change, :stock_quote_change
end
