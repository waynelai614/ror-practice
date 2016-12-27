require 'rails_helper'

RSpec.describe Turnover, type: :model do
  subject(:turnover) { 
    turnover = Turnover.new()
    turnover.save
    turnover
  }
  context "collection 'turnover'" do 
    it { is_expected.to be_valid }

    it "should include Mongoid::Timestamps::'Created' and 'Updated'" do
      is_expected.to be_timestamped_document.with(:created) 
    end
  end  

end