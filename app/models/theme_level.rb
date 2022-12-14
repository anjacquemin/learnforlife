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

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :theme
  validates :objective, presence: true
  validates :level, presence: true

  validates :name, length: { maximum: 10 }
  validates :objective, length: { maximum: 300 }
  validates :level, numericality: { greater_than: 0 }

end
