FactoryGirl.define do

  # This will use the User class (Admin would have been guessed)
  factory :stockController do

    
    factory :requestOpt do
      start_date { '19940314' }
      end_date { '19940315' }
      stock_number { [123, 123] }

      # for valiadation
      factory :start_date_unexpected do
        start_date nil
      end
      factory :end_date_unexpected do
        end_date nil
      end
      factory :stock_number_unexpected do
        stock_number nil
      end
      factory :stock_number_empty do
        stock_number nil
      end
    end

    # empty req 
    factory :empty do
      start_date nil
      end_date nil
      stock_number nil
    end

    # for query database
    factory :query_with_number_date do
      timestamps { Time.new(1994, 3, 14).beginning_of_day..Time.new(1994, 3, 15).end_of_day }
      stock_number { attributes_for(:requestOpt).fetch(:stock_number).first }
    end

    factory :query_without_number do
      timestamps { Time.new(1994, 3, 14).beginning_of_day..Time.new(1994, 3, 15).end_of_day }
    end
  end
end
