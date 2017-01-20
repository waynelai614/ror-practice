require 'rails_helper'
require 'crawler'

RSpec.describe StockController, type: :controller do

  # REST-ful routes
  describe 'GET #index' do
    context 'when query data normally' do
      before(:each) do
        # stub method 'launch'
        allow(controller).to receive(:launch)
          .and_return(build_list(:turnover, Crawler::DATA_COUNT))
        get :index
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response).to render_template('index') }
    end
  end

  describe 'POST #create' do
    context 'when query data normally' do
      before(:each) do
        allow(controller).to receive(:launch)
          .and_return(build_list(:turnover, Crawler::DATA_COUNT))
        post :create
      end
      it { expect(response).to have_http_status(200) }
      it { expect(response.content_type).to eq 'application/json' }
    end
  end

  describe '.argument_init' do
    context "when 'start_date' is reasonable" do
      subject do
        controller
          .argument_init(attributes_for(:requestOpt))
          .fetch(:start_date)
      end
      it { is_expected.to be_instance_of(Time) }
    end

    context "when 'start_date' is unexpected" do
      subject do
        controller
          .argument_init(attributes_for(:start_date_unexpected))
          .fetch(:start_date)
      end

      it { is_expected.to be_instance_of(Time) }
      it 'should be today' do
        expect(Time.now.end_of_day.to_i - subject.to_i).to be < 60 * 60 * 24
      end
    end


    context "when 'end_date' is reasonable" do
      subject do
        controller
          .argument_init(attributes_for(:requestOpt))
          .fetch(:end_date)
      end
      it { is_expected.to be_instance_of(Time) }
    end

    context "when 'end_date' is unexpected" do
      subject do
        controller
          .argument_init(attributes_for(:end_date_unexpected))
          .fetch(:end_date)
      end

      it { is_expected.to be_instance_of(Time) }
      it 'should be today' do
        expect(Time.now.end_of_day.to_i - subject.to_i).to be < 60 * 60 * 24
      end
    end

    context "when 'stock_number' under expection" do
    end

    context "when 'stock_number' is unexpected" do
    end
  end

  # twos things in launch method
  # 1. validation
  # 2. return query result
  describe '.launch' do
    context 'without query conditions' do
    
    end

    context 'with query condition' do
      
      context "when 'start_date' is unexpected" do
  
      end


    end

    describe 'when query database' do
      context 'with company' do
     


      end

      context 'without company' do
      end


      context 'fail' do

      end

    end

  end
end
