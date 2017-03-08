FactoryGirl.define do
  factory :turnover do
    stock_code 2603
    stock_name '長榮'
    stock_company_uri 'http://stock.wearn.com/a2603.html'
    stock_opening_price 15.3
    stock_highest_price 15.75
    stock_lowest_price 15.2
    stock_closing_yesterday 15
    stock_closing_today 15.3
    stock_volume 39_130
    stock_change 0.3
    stock_quote_change 2
  end
end
