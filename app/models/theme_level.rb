class ThemeLevel < ApplicationRecord
  belongs_to :theme
  has_many :theme_level_progresses
  has_many :subthemes
  has_many :categories, class_name: :Category, through: :subthemes
  has_many :quizz_levels, through: :subthemes
  has_many :quizz_progresses, through: :subthemes
  has_many :category_progresses, through: :subthemes
  has_many :quizz_level_progresses, through: :subthemes
  has_many :question_answers, through: :subthemes



  validates :name, length: { maximum: 10 }
  validates :objective, length: { maximum: 140 }
  validates :level, numericality: { greater_than: 0 }

end
