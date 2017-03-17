require 'rails_helper'

RSpec.describe Turnover, type: :model do
  context 'when normal data' do
    subject { build(:turnover) }
    it 'is include valid "stock_code" and "stock_name"' do
      is_expected.to be_valid
    end

    it 'is include timestamp "created_at" and "updated_at"' do
      is_expected.to have_attributes(created_at: be_a(Time), updated_at: be_a(Time))
    end

    it 'verify data type' do
      is_expected.to have_attributes(
        stock_code: be_a(Integer),
        stock_name: be_a(String),
        stock_company_uri: be_a(String),
        stock_opening_price: be_a(Float),
        stock_highest_price: be_a(Float),
        stock_lowest_price: be_a(Float),
        stock_closing_yesterday: be_a(Float),
        stock_closing_today: be_a(Float),
        stock_volume: be_a(Integer),
        stock_change: be_a(Float),
        stock_quote_change: be_a(Float),
        created_at: be_a(Time),
        updated_at: be_a(Time)
      )
    end
  end

  context 'when invalid data' do
    it 'does not include "stock_code"' do
      turnover = build(:turnover_without_code)
      expect(turnover).not_to be_valid
    end

    it 'does not include "stock_name"' do
      turnover = build(:turnover_without_name)
      expect(turnover).not_to be_valid
    end

    it 'invalid "stock_code"' do
      turnover = build(:turnover_invalid_code)
      expect(turnover).not_to be_valid
    end
  end

  context 'when query database' do
    # run one time only, before all of the examples in a group
    before(:context) do
      create_list(:turnover, Crawler::DATA_COUNT)
      @code = Turnover.first.stock_code
      # get two stock codes from Turnovers
      @codes = Turnover.first(2).map(&:stock_code)
      @date = Turnover.find_distinct_date[0].to_time
      # '%F' => 2017-03-16
      @date_string = @date.strftime('%F')
    end
    # after context, clean the table
    after(:context) do
      Turnover.delete_all
    end

    it 'find by one stock code' do
      expect(Turnover.find_by_code(@code).first.stock_code).to eq(@code)
    end

    it 'find by multi stock codes' do
      turnover_codes = Turnover.find_by_code(@codes).map(&:stock_code).uniq
      expect(turnover_codes).to eq(@codes)
    end

    it 'find by created date' do
      expect(Turnover.find_by_date(@date).first[:created_at].strftime('%F')).to eq(@date_string)
    end

    context 'both query stock code and created date' do
      it 'find by one stock code' do
        turnovers = Turnover.find_by_code_and_date(@code, @date)
        expect(Turnover.find_by_code(@code).first.stock_code).to eq(@code)
        expect(turnovers.first[:created_at].strftime('%F')).to eq(@date_string)
      end

      it 'find by multi stock codes' do
        turnovers = Turnover.find_by_code_and_date(@codes, @date)
        expect(turnovers.map(&:stock_code).uniq).to eq(@codes)
        expect(turnovers.first[:created_at].strftime('%F')).to eq(@date_string)
      end
    end

    it 'find distinct date and return array' do
      # length will be 1 because only create today's fake turnover data
      expect(Turnover.find_distinct_date.length).to eq(1)
    end
  end
end
