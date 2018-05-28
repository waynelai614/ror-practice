class CreateTurnovers < ActiveRecord::Migration
  def change
    create_table :turnovers do |t|
      t.integer :stock_id
      t.integer :stock_no
      t.string :stock_name
      t.float :stock_opening_price
      t.float :stock_highest_price
      t.float :stock_lowest_price
      t.float :stock_closing_yesterday
      t.float :stock_closing_today
      t.float :stock_volumn
      t.float :stock_change
      t.float :stock_change_range

      t.timestamps
    end
  end
end
