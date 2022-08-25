class QuizzLevel < ApplicationRecord
  belongs_to :quizz
  has_many :question_answers, through: :quizz
  has_one :theme, through: :quizz
  has_one :category, through: :quizz
  has_many :quizz_level_progresses
  has_many :records
  has_many :quizz_answers
  has_many :best_records
  validates :name, presence: true
end
