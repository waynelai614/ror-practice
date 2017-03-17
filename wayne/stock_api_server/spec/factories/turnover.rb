FactoryGirl.define do
  factory :turnover do
    stock_code { Faker::Number.number(4) }
    stock_name { Faker::Name.name }
    stock_company_uri { Faker::Internet.url('stock.wearn.com') }
    stock_opening_price { Faker::Number.decimal(2) }
    stock_highest_price { Faker::Number.decimal(2) }
    stock_lowest_price { Faker::Number.decimal(2) }
    stock_closing_yesterday { Faker::Number.decimal(2) }
    stock_closing_today { Faker::Number.decimal(2) }
    stock_volume { Faker::Number.number(5) }
    stock_change { Faker::Number.decimal(2) }
    stock_quote_change { Faker::Number.decimal(2) }

    created_at Time.now
    updated_at Time.now

    factory :turnover_without_code do
      stock_code nil
    end

    factory :turnover_without_name do
      stock_name nil
    end

    factory :turnover_invalid_code do
      stock_code 777
    end
  end
end
