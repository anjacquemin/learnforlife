class Theme < ApplicationRecord
  validates :name, presence: true
  has_many :theme_levels
  has_many :subthemes, through: :theme_levels
end
