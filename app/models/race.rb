class Race < ApplicationRecord
  has_many :laps
  has_many :teams, through: :laps
end
