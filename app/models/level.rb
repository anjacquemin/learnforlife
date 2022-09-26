class Level < ApplicationRecord
  validates :level, presence: true
  validates :required_xp, presence: true
  validates :beginning_year, presence: true
  validates :period, presence: true
  validates :sub_period, presence: true
end
