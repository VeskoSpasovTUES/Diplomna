class Lap < ApplicationRecord
  belongs_to :team
  belongs_to :race
end
