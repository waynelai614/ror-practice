FactoryGirl.define do
  factory :turnover do
    stock_number 6116
    stock_name "彩晶"
    stock_company_hyperlink "http://stock.wearn.com/a6116.html"
    stock_opening_price 8.58
    stock_highest_price 8.68
    stock_floor_price 8.32
    stock_closing_yesterday 8.11
    stock_closing_today 8.33
    stock_volumn 149249
    stock_change 0.22
    stock_quote_change "2.71%  "
    timestamps { Time.now }

    factory :turnover_unexpected do
      stock_number nil
      stock_name nil
    end
  end
end
