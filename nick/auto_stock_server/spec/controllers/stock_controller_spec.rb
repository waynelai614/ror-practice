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

    context "when 'stock_number' is reasonable" do
      subject do
        controller
          .argument_init(attributes_for(:requestOpt))
          .fetch(:stock_number)
      end
      it { is_expected.to be_instance_of(Array) }
      context 'the elements' do
        it { expect(subject.first).to be_kind_of(Integer) }
      end
    end

    context "when 'stock_number' is unexpected" do
      subject do
        controller
          .argument_init(attributes_for(:stock_number_unexpected))
          .fetch(:stock_number)
      end
      it { is_expected.to be_instance_of(Array) }
      it { is_expected.to be_empty }
    end
  end

  # twos things in launch method
  # 1. validation
  # 2. return query result
  describe '.launch' do
    context 'without query conditions' do
      before(:each) do
        allow(controller).to receive(:turnover_select)
          .and_return(build_list(:turnover, Crawler::DATA_COUNT))
      end
      context 'return' do
        it { expect(controller.launch).to be_instance_of(Array) }
      end
      context 'elements of what we return' do
        it { expect(controller.launch.first).to be_instance_of(Turnover) }
      end
    end

    describe 'when query database' do
      before(:each) do
        # options that simulate to pass by user
        opt = controller.argument_init(attributes_for(:requestOpt))
        @passing_date = ((opt.fetch(:end_date).end_of_day - opt.fetch(:start_date).beginning_of_day) / 1.day).ceil
        # mock the query in Database
        # return today's turnover without opts by default
        double(Turnover)
        allow(Turnover).to receive(:where)
          .and_return(build_list(:turnover, Crawler::DATA_COUNT))

        # query without number
        query_without_number = attributes_for(:query_without_number)
        allow(Turnover).to receive(:where)
          .with(query_without_number)
          .and_return(build_list(:turnover, @passing_date * Crawler::DATA_COUNT))

        # query with number and dates
        query_with_number_date = attributes_for(:query_with_number_date)
        allow(Turnover).to receive(:where)
          .with(query_with_number_date)
          .and_return(build_list(:turnover, @passing_date, stock_number: query_with_number_date.fetch(:stock_number)))
      end

      context 'with nothing' do
        before(:each) do
          # return today's turnover without opts by default
          controller.params = attributes_for(:empty)
        end
        subject { controller.launch }
        context 'should select today\'s turnover' do
          its(:size) { is_expected.to eq Crawler::DATA_COUNT }
        end
      end

      context 'without company' do
        before(:each) do
          controller.params = attributes_for(:stock_number_empty)
        end
        subject { controller.launch }
        context 'should select all turnovers between dates' do
          its(:size) { is_expected.to eq Crawler::DATA_COUNT * @passing_date }
        end
      end

      context 'with both date and company' do
        before(:each) do
          controller.params = attributes_for(:requestOpt)
        end
        subject { controller.launch }
        context 'should select the turnovers of companys between dates' do
          it { expect(attributes_for(:requestOpt).fetch(:stock_number)).to include subject.first.stock_number }
          its(:size) do
            company_length = attributes_for(:requestOpt).fetch(:stock_number).size
            is_expected.to eq @passing_date * company_length 
          end
        end
      end

    end

  end
end
