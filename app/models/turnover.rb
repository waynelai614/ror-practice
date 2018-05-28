class Turnover < ActiveRecord::Base
  attr_accessible :stock_change, :stock_change_range, :stock_closing_today, :stock_closing_yesterday, :stock_highest_price, :stock_id, :stock_lowest_price, :stock_name, :stock_no, :stock_opening_price, :stock_volumn
end
