class CreateLaps < ActiveRecord::Migration[7.1]
  def change
    create_table :laps do |t|
      t.float :time
      t.integer :number

      t.timestamps
    end
  end
end
