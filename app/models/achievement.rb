class Achievement < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :xp_to_win, presence: true, numericality: { greater_than_or_equal_to: 0}
end
