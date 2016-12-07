class CreateTurnovers < ActiveRecord::Migration
  def change
    create_table :turnovers do |t|
      t.string :stock_number
      t.string :stock_name
      t.float :stock_opening_price
      t.float :stock_highest_price
      t.float :stock_floor_price
      t.float :stock_closing_yesterday
      t.float :stock_closing_today
      t.string :stock_volumn
      t.float :stock_change
      t.string :stock_quote_change

      t.timestamps null: false
    end
  end
end
