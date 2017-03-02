class CreateTurnovers < ActiveRecord::Migration
  def change
    create_table :turnovers do |t|
      t.integer :stock_code
      t.string :stock_name
      t.string :stock_company_uri
      t.float :stock_opening_price
      t.float :stock_highest_price
      t.float :stock_lowest_price
      t.float :stock_closing_yesterday
      t.float :stock_closing_today
      t.integer :stock_volume
      t.float :stock_change
      t.float :stock_quote_change

      t.timestamps
    end
  end
end
