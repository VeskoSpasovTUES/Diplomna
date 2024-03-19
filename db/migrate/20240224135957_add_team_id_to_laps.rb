class AddTeamIdToLaps < ActiveRecord::Migration[7.1]
  def change
    add_reference :laps, :team, foreign_key: true
  end
end
