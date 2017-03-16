require 'rails_helper'
require 'crawler'

RSpec.describe StockController, type: :controller do
  let(:data_count) { Crawler::DATA_COUNT }
  let(:filename_test) { 'turnovers.xlsx' }
  describe 'GET #index' do
    context 'when loads the default data' do
      before(:each) do
        allow(controller).to receive(:sort_array_of_obj)
          .and_return(build_list(:turnover, data_count))
      end

      it 'return JSON data' do
        get :index, format: :json
        turnovers = JSON.parse response.body
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq Mime::JSON.to_s
        expect(turnovers.length).to eq(data_count)
      end

      it 'downloads an excel file from respond_to while specifying filename' do
        get :index, format: :xlsx
        expect(response.content_type).to eq(Mime::XLSX.to_s)
        expect(response.headers['Content-Disposition']).to include("filename=\"#{filename_test}\"")
        expect(response).to render_template('stock/index')
      end
    end
  end
end
