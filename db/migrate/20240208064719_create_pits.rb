class CreatePits < ActiveRecord::Migration[7.1]
  def change
    create_table :pits do |t|
      t.integer :time
      t.integer :lap_number
      t.timestamps
    end
  end
end
