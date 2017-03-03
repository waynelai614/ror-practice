class Turnover < ActiveRecord::Base
  validates_format_of :stock_code, with: /[0-9]{4}/
  validates_presence_of :stock_name

  attr_accessible *%i[
    stock_code
    stock_name
    stock_company_uri
    stock_opening_price
    stock_highest_price
    stock_lowest_price
    stock_closing_yesterday
    stock_closing_today
    stock_volume
    stock_change
    stock_quote_change
  ]
end
