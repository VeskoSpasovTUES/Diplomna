class AddRaceIdToLaps < ActiveRecord::Migration[7.1]
  def change
    add_reference :laps, :race, foreign_key: true
  end
end
