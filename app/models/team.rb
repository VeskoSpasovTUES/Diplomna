class Team < ApplicationRecord
  has_many :laps
  has_many :pits
  has_many :races, through: :pits
end
