class CreateTurnovers < ActiveRecord::Migration
  def change
    create_table :turnovers do |t|

      t.timestamps
    end
  end
end
