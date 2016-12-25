require "rails_helper"
require "Crawler"

RSpec.describe StockController, :type => :controller do
  describe "GET #index" do
    context "when responds successfully" do 
      it {
        expect(response).to be_success
        get :index
        expect(response).to have_http_status(200)
      }
      
    end 

    context "when rendering the index template" do 
      it {
        get :index
        expect(response).to render_template("index")
      }
    end 

  end

  describe "POST #create" do
    before(:each) {
      Crawler.crawl_data_to_db
    }

    context "response data type " do 
      it {
        post :create
        expect(response.content_type).to eq "application/json"
      }
    end 

    context "without receiving arguments," do 
      context "today's turnover by default " do 
        subject {
          post :create
          JSON.parse(response.body)
        }
        its(:length) {
          is_expected.to eq Crawler::DATA_COUNT
        }
      end 
      
    end

    context "receiving arguments, " do 
      context "when 'date' is selected" do 
        subject(:result) {
          opt = {
            # given option
            :start_date => DateTime.yesterday.beginning_of_day,
            :end_date => DateTime.now.end_of_day
          }
          post :create, opt
          JSON.parse(response.body)
        }
        
        it "length of turnovers should less than DAY * COUNT" do 
          expect(result.length).to be <= Crawler::DATA_COUNT * 2 
        end
      end 
      context "when 'stock_number' is selected " do 
        context "and companys exist " do 
          subject(:result) {

            # get today's turnover and get the stock number of the first and secondcompany
            stock_number = Crawler.get_daily_data(2).map do |company|
              company[:stock_number]
            end 
            post :create, :stock_number => stock_number
            JSON.parse(response.body)
          }

          it { expect(result).to be_instance_of Array }
          its(:length) { is_expected.to eq 2 }  

        end 

        context "but companys don't exist, result " do 
          subject(:result) {
            post :create, :stock_number => [-1]
            JSON.parse(response.body)
          }

          # result should be empty array 
          it { expect(result).to be_instance_of Array }
          its(:length) { is_expected.to eq 0 }  
        end 
        
      end 
    end 

  end 
end
