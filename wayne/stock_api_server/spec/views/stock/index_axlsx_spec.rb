require 'rails_helper'
require 'roo'

RSpec.describe 'stock/index.xlsx.axlsx', type: :view do
  after(:each) do
    if File.exist? '/tmp/axlsx_temp.xlsx'
      File.unlink '/tmp/axlsx_temp.xlsx'
    end
  end
  it 'displays the turnover first column' do
    assign :turnovers, build_list(:turnover, 10)
    render
    # Rails.logger.debug rendered
    File.open('/tmp/axlsx_temp.xlsx', 'w') { |f| f.write(rendered) }
    wb = nil
    expect { wb = Roo::Excelx.new('/tmp/axlsx_temp.xlsx') }.to_not raise_error
    expect(wb.cell(1, 1)).to eq('代號')

    # expect(rendered).to have_css("header h1", text: "Buy milk")
  end
end
