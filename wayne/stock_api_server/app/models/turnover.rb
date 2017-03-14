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

  def self.find_by_code(codes)
    Turnover.where(stock_code: [codes])
  end

  def self.find_by_date(date)
    Turnover.where(created_at: date.beginning_of_day..date.end_of_day)
  end

  def self.find_by_code_and_date(codes, date)
    Turnover
      .where(stock_code: [codes])
      .where(created_at: date.beginning_of_day..date.end_of_day)
  end

  def self.find_distinct_date
    Turnover
      .select("distinct(to_char(created_at, 'YYYY-MM-DD'))")
      .map(&:to_char)
      .sort
      .reverse
  end
end
