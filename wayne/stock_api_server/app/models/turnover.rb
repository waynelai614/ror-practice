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

  def self.find_by_code(code)
    Turnover.where(stock_code: code)
  end

  def self.find_by_date(date)
    Turnover.where(created_at: date.beginning_of_day..date.end_of_day)
  end

  def self.find_by_code_and_date(code, date)
    Turnover
      .where(stock_code: code)
      .where(created_at: date.beginning_of_day..date.end_of_day)
  end

  def self.sort_by(column, direction)
    # return the exist column name, default: 'created_at'
    sort_column = Turnover.column_names.include?(column) ? column : 'created_at'
    # return the sort direction, default: 'asc'
    sort_direction = %w(asc desc).include?(direction) ? direction : 'asc'
    Turnover.order(sort_column + ' ' + sort_direction)
  end
end
