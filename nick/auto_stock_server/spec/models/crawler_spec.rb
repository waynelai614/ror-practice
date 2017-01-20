require 'rails_helper'
require 'crawler.rb'

describe Crawler do 
  describe ".crawl_data_to_db" do 
    subject(:turnovers) do 
      Crawler.crawl_data_to_db
      Turnover.where(
        :timestamps => Time.now.beginning_of_day..Time.now.end_of_day
      )
    end 
    
    context "DB is accessible" do 
      context "DB for 'Test' " do 
        it "no exception when connecting" do 
          expect{ Turnover.new().save }.to_not raise_error()
        end  
      end 
      
      context "When in 'mLab' " do 
        it "no exception when connecting" do 

          # to make sure it could access to mLab
          result = system('nc -w 3 ds127878.mlab.com 27878 ')
          expect(result).to be_truthy 
        end  
      end 
    end

    # data in DB cannot be repeated
    context "length of unique data count in DB " do 
      subject(:arr_stock_name) {
        turnovers.map do |t|
          t[:stock_number]
        end 
      }
      it { expect(arr_stock_name.uniq.length).to eq arr_stock_name.length }
    end 

    context "today's turnovers" do 
      its(:length) { is_expected.to eq (Crawler::DATA_COUNT) }
    end 

  end

  describe ".get_daily_data" do 

    before(:all) do 
      @turnovers = Crawler.get_daily_data
    end 

    context 'data what we got' do 
      subject {@turnovers}
      its(:length) { is_expected.to eq (Crawler::DATA_COUNT) }
    end 

    context 'verify attribute data format ' do 
      
      subject { @turnovers[0] } 
      its([:stock_number]) do
        is_expected.to be_instance_of String 
      end
      
      its([:stock_name]) do 
        is_expected.to be_instance_of String 
      end
      its([:stock_company_hyperlink]) do 
        is_expected.to be_instance_of String 
      end
      its([:stock_opening_price]) do 
        is_expected.to be_instance_of Float 
      end
      its([:stock_highest_price]) do 
        is_expected.to be_instance_of Float 
      end
      its([:stock_floor_price]) do 
        is_expected.to be_instance_of Float 
      end
      its([:stock_closing_yesterday]) do 
        is_expected.to be_instance_of Float 
      end
      its([:stock_closing_today]) do 
        is_expected.to be_instance_of Float 
      end
      its([:stock_volumn]) do 
        is_expected.to be_instance_of Fixnum 
      end
      its([:stock_change]) do 
        is_expected.to be_instance_of Float 
      end
      its([:stock_quote_change]) do 
        is_expected.to be_instance_of String 
      end

    end 
  end


end 
