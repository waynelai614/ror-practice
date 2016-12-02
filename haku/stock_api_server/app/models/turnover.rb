class Turnover
  include Mongoid::Document
  include Mongoid::Timestamps

  field :stock_code, type: Integer
  field :stock_name, type: String
  field :opening_price, type: Float
  field :highest_price, type: Float
  field :lowest_price, type: Float
  field :closing_ytd, type: Float
  field :closing_today, type: Float
  field :trading_volume, type: Integer
  field :change, type: Float
  field :change_limit, type: String
  field :timestamp, type: Time, default: ->{ Time.now }

  def self.delete_today
    now = Time.new
    tmr = now + (60 * 60 * 24)

    Turnover.where(
      :timestamp.gte => "#{now.year}-#{now.month}-#{now.day}",
      :timestamp.lt => "#{tmr.year}-#{tmr.month}-#{tmr.day}"
    ).delete
  end

  def self.save_new_turnovers(row)
    turnover = Turnover.new
    turnover.stock_code = row[:stock_code]
    turnover.stock_name = row[:stock_name]
    turnover.opening_price = row[:opening_price]
    turnover.highest_price = row[:highest_price]
    turnover.lowest_price = row[:lowest_price]
    turnover.closing_ytd = row[:closing_ytd]
    turnover.closing_today = row[:closing_today]
    turnover.trading_volume = row[:trading_volume]
    turnover.change = row[:change]
    turnover.change_limit = row[:change_limit]
    turnover.save
  end
end
