require 'rails_helper'
require 'crawler'

RSpec.describe Crawler do
  # 'let' is lazy-evaluated: it is not evaluated until the first time
  # the method it defines is invoked.
  let(:plain_data) { attributes_for(:crawler).fetch(:plain_data) }

  let(:crawl_data) do
    # get specific html
    html = attributes_for(:crawler).fetch(:html)
    # change the method 'html_parse' return value
    allow(Crawler).to receive(:html_parse) { Nokogiri::HTML.parse(html) }
    Crawler.crawl
  end

  let(:change_positive_data) { crawl_data.first }
  let(:change_nagative_data) { crawl_data[1] }
  let(:change_zero_data) { crawl_data[2] }

  context 'when crawled data and save to db' do
    it { expect(Turnover.new(crawl_data.first)).to be_valid }
  end

  context 'when query turnovers from the website' do
    it 'verify data value' do
      expect(crawl_data.first).to match(plain_data)
    end
  end

  context 'when crawled stock change data' do
    it 'font color is red' do
      expect(change_positive_data[:stock_change]).to be > 0
    end
    it 'font color is green' do
      expect(change_nagative_data[:stock_change]).to be < 0
    end
    it 'does not include font color' do
      expect(change_zero_data[:stock_change]).to eq(0)
    end
  end
end
