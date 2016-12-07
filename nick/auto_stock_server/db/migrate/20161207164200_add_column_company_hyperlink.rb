class AddColumnCompanyHyperlink < ActiveRecord::Migration
  def change
     add_column :turnovers, :stock_company_hyperlink, :string
  end
end
