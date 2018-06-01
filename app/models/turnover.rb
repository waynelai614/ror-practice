class Turnover < ActiveRecord::Base
  attr_accessible :stock_change, :stock_closing_today, :stock_closing_yesterday, :stock_code, :stock_company_url, :stock_highest_price, :stock_lowest_price, :stock_name, :stock_opening_price, :stock_quote_change, :stock_volumn
end
