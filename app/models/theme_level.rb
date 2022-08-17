class ThemeLevel < ApplicationRecord
  belongs_to :theme
  has_many :theme_level_progresses
  has_many :subthemes
  has_many :quizz_levels, through: :subthemes

  validates :name, length: { maximum: 10 }
  validates :objective, length: { maximum: 140 }
  validates :level, numericality: { greater_than: 0 }

end
