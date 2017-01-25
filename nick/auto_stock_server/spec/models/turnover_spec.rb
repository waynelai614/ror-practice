require 'rails_helper'

RSpec.describe Turnover, type: :model do
  context 'when normal query data' do
    subject { build(:turnover) }
    it { is_expected.to be_valid }

    it "should include Mongoid::Timestamps::'Created' and 'Updated'" do
      is_expected.to be_timestamped_document.with(:created)
    end

    context 'data format' do
      it { is_expected.to have_field(:stock_name).of_type(String) }
      it { is_expected.to have_field(:stock_number).of_type(Integer) }
      it { is_expected.to have_field(:stock_company_hyperlink).of_type(String) }
      it { is_expected.to have_field(:stock_opening_price).of_type(Float) }
      it { is_expected.to have_field(:stock_highest_price).of_type(Float) }
      it { is_expected.to have_field(:stock_floor_price).of_type(Float) }
      it { is_expected.to have_field(:stock_closing_yesterday).of_type(Float) }
      it { is_expected.to have_field(:stock_closing_today).of_type(Float) }
      it { is_expected.to have_field(:stock_volumn).of_type(Integer) }
      it { is_expected.to have_field(:stock_change).of_type(Float) }
      it { is_expected.to have_field(:stock_quote_change).of_type(String) }
      it { is_expected.to have_field(:timestamps).of_type(Time) }
    end
  end

  context 'if data format is unexpected' do

    context 'when stock_number is empty ' do
      subject { build(:turnover_without_number) }
      it { is_expected.not_to be_valid }

    end
    context 'when stock_name is empty ' do
      subject { build(:turnover_without_name) }
      it { is_expected.not_to be_valid }
    end

  end

end
