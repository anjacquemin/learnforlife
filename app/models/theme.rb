class Theme < ApplicationRecord
  validates :name, presence: true
  has_many :theme_levels
  has_many :subthemes, through: :theme_levels
  has_many :quizz_levels, through: :theme_levels
  has_many :best_records

  has_one_attached :photo
end
