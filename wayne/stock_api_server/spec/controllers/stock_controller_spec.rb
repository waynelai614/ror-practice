require 'rails_helper'

RSpec.describe StockController, type: :controller do
  # make private methods as public:
  StockController.send(:public, *StockController.private_instance_methods)

  let(:data_count) { Crawler::DATA_COUNT }
  let(:fake_turnovers) { build_list(:turnover, data_count) }
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
        expect(response.headers['Content-Disposition']).to include("filename=\"#{StockController::XLSX_FILENAME}\"")
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

  context 'when params has "codes"' do
    before(:context) do
      @code = '1314'
      @codes_with_comma = '1314,6116'

      @code_array = @code.split(',').map(&:strip)
      @codes_array = @codes_with_comma.split(',').map(&:strip)
    end

    it 'only one stock code' do
      expect(controller.split_str_by_comma(@code)).to eq(@code_array)
    end

    it 'comma-separated multi stock codes' do
      expect(controller.split_str_by_comma(@codes_with_comma)).to eq(@codes_array)
    end
  end

  context 'when params has "date"' do
    before(:context) do
      @date = '20170316'
      @error_date = '2015316093281'
    end

    it 'standard date formats' do
      expect(controller.date_verify(@date)).to eq(Time.parse(@date))
    end

    it 'unkonwn date formats' do
      # if date format doesn't match, return Time.now
      # due to the delay, test the date format
      expect(controller.date_verify(@error_date).strftime('%F')).to eq(Time.now.strftime('%F'))
    end
  end

  context 'when params has "sort" & "direction"' do
    before(:context) do
      @sort = 'stock_code'
      @error_sort = 'idontknow'
      @direction = 'asc'
      @error_direction = 'reverse'
    end

    context 'sort value' do
      it 'can\'t find sort column in Turnover model' do
        # if not exist, return 'id' column
        expect(controller.sort_column_verify(@error_sort)).to eq('id')
      end
      it 'found sort column in Turnover model' do
        expect(controller.sort_column_verify(@sort)).to eq(@sort)
      end
    end

    context 'direction value' do
      it 'invalid, not "asc" or "desc"' do
        # if not valid, return default 'asc'
        expect(controller.direction_verify(@error_direction)).to eq('asc')
      end
      it 'valid' do
        expect(controller.direction_verify(@direction)).to eq(@direction)
      end
    end

    it 'return result with correct order' do
      turnovers = controller.sort_array_of_obj(fake_turnovers, @sort, @direction).first(2)
      first_stock_code = turnovers[0].stock_code
      second_stock_code = turnovers[1].stock_code
      expect(first_stock_code).to be < second_stock_code
    end
  end
end
