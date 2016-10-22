class Turnover
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

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
end
