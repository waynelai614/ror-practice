class CreateTurnovers < ActiveRecord::Migration[5.0]
  def change
    create_table :turnovers do |t|

      t.timestamps
    end
  end
end
