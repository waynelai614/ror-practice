require 'rails_helper'
require 'crawler'

RSpec.describe StockController, type: :controller do
  let(:data_count) { Crawler::DATA_COUNT }
  let(:fake_turnovers) { build_list(:turnover, data_count) }
  let(:filename_test) { 'turnovers.xlsx' }
  let(:distinct_date) { %w(20170315 20170316) }

  describe 'GET #index' do
    context 'when loads the default data' do
      before(:each) do
        # without hitting the database
        allow(controller).to receive(:sort_array_of_obj)
          .and_return(fake_turnovers)
      end

      it 'return JSON data' do
        # /api/stock.json
        get :index, format: :json
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq Mime::JSON.to_s
        expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
        expect((JSON.parse response.body).length).to eq(data_count)
      end

      it 'downloads an excel file from respond_to while specifying filename' do
        # /api/stock.xlsx
        get :index, format: :xlsx
        expect(response.content_type).to eq(Mime::XLSX.to_s)
        expect(response.headers['Content-Disposition']).to include("filename=\"#{filename_test}\"")
        expect(response).to render_template('stock/index')
      end
    end
  end

  describe 'GET #date' do
    context 'when loads the avaliable date string' do
      before(:each) do
        # without hitting the database
        allow(Turnover).to receive(:find_distinct_date)
          .and_return(distinct_date)
      end
      it 'return JSON data' do
        get :date
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq Mime::JSON.to_s
        expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
        expect((JSON.parse response.body).length).to eq(distinct_date.length)
      end
    end
  end

  describe 'POST #crawl' do
    context 'when crawled data and update today\'s turnovers' do
      before(:each) do
        allow(Crawler).to receive(:crawl_data_to_db)
          .and_return(fake_turnovers)
      end
      it 'return JSON data' do
        get :crawl
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq Mime::JSON.to_s
        expect((JSON.parse response.body).fetch('status')).to eq(StockController::SUCCESS_STR)
      end
    end
  end
end
