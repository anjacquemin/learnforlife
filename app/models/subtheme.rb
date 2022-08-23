class Subtheme < ApplicationRecord
  belongs_to :theme_level
  has_many :subtheme_progresses
  has_many :categories, class_name: :Category
  has_many :question_answers, through: :categories
  has_many :quizz_levels, through: :categories
  has_many :quizzs, class_name: :Quizz, through: :categories
  has_many :quizz_progresses, through: :categories
  has_many :category_progresses, through: :categories
  has_many :quizz_level_progresses, through: :categories
  has_many :records, through: :categories

  has_one :theme, through: :theme_level

  validates :name, presence: true
end
