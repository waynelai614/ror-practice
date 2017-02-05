require 'rails_helper'
require 'crawler.rb'

describe Crawler do
  # 1. delete today data in DB
  # 2. update data in DB
  describe '.crawl_data_to_db' do
    # stub delete_repeat
    # stub get_daily_data
    # stub Turnover.save => be_valid return true
  end

  # got different Nokogiri::HTML when given specific html file
  # 1. got html or nothing atfer querying
  # 2. situation when change >0, <0, ==0
  describe '.get_daily_data' do
    context 'when query turnovers from the website normally' do
      before(:each) do
        html = attributes_for(:crawler).fetch(:html)
        allow(Crawler).to receive(:html_parse)
          .and_return(Nokogiri::HTML.parse(html))
      end
      context 'return should ' do
        subject { Crawler.get_daily_data }
        it { is_expected.to be_an_instance_of(Array) }
        it { is_expected.to_not be_empty }
        its(:size) { is_expected.to be <= Crawler::DATA_COUNT }
      end
      context 'data format of ' do
        subject { Crawler.get_daily_data.first }
        its([:stock_number]) { is_expected.to be_kind_of(String) }
        its([:stock_name]) { is_expected.to be_kind_of(String) }
        its([:stock_company_hyperlink]) { is_expected.to be_kind_of(String) }
        its([:stock_opening_price]) { is_expected.to be_kind_of(Float) }
        its([:stock_highest_price]) { is_expected.to be_kind_of(Float) }
        its([:stock_floor_price]) { is_expected.to be_kind_of(Float) }
        its([:stock_closing_yesterday]) { is_expected.to be_kind_of(Float) }
        its([:stock_closing_today]) { is_expected.to be_kind_of(Float) }
        its([:stock_volumn]) { is_expected.to be_kind_of(Integer) }
        its([:stock_change]) { is_expected.to be_kind_of(Float) }
        its([:stock_quote_change]) { is_expected.to be_kind_of(String) }
      end
    end
    context 'after querying but got nothing' do
      before(:each) do
        html = attributes_for(:crawler).fetch(:html_empty)
        allow(Crawler).to receive(:html_parse)
          .and_return(Nokogiri::HTML.parse(html))
      end
      subject { Crawler.get_daily_data }
      context 'return should ' do
        it { is_expected.to be_an_instance_of(Array) }
        it { is_expected.to be_empty }
      end
    end

    context 'font color of change' do
      context 'when color is green' do
        before(:each) do
          html = attributes_for(:crawler).fetch(:change_nagative)
          allow(Crawler).to receive(:html_parse)
            .and_return(Nokogiri::HTML.parse(html))
        end
        subject { Crawler.get_daily_data.first.fetch(:stock_change) }
        context 'stock change value ' do
          it { is_expected.to be < 0 }
        end
      end
      context 'when color is red' do
        before(:each) do
          html = attributes_for(:crawler).fetch(:change_positive)
          allow(Crawler).to receive(:html_parse)
            .and_return(Nokogiri::HTML.parse(html))
        end
        subject { Crawler.get_daily_data.first.fetch(:stock_change) }
        context 'stock change value ' do
          it { is_expected.to be > 0 }
        end
      end

      context 'when find no font color ' do
        before(:each) do
          html = attributes_for(:crawler).fetch(:change_zero)
          allow(Crawler).to receive(:html_parse)
            .and_return(Nokogiri::HTML.parse(html))
        end
        subject { Crawler.get_daily_data.first.fetch(:stock_change) }
        context 'stock change value ' do
          it { is_expected.to eq(0) }
        end
      end
    end
  end
end

