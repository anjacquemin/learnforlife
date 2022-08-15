class QuizzLevel < ApplicationRecord
  belongs_to :quizz
  has_one :theme, through: :quizz
  has_many :quizz_level_progresses
  has_many :records
  has_many :quizz_answers
  validates :name, presence: true
end
