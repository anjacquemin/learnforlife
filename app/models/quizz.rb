class Quizz < ApplicationRecord
  belongs_to :category
  has_many :quizz_progresses
  has_many :quizz_levels
  has_many :quizz_answers
  has_many :question_answers
  has_one :theme, through: :category

  validates :name, presence: true
end
