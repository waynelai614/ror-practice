require 'rails_helper'

RSpec.describe Turnover, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "Test factory_girl works" do
    turnover = build(:turnover)
    turnover.stock_code = 1111
    turnover.stock_name = 'test'
    expect(turnover['stock_code']).to eq(1111)
  end
end
