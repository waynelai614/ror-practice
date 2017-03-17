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
end
