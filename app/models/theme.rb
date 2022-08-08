class Theme < ApplicationRecord
  validates :name, presence: true
  has_many :theme_levels
end
