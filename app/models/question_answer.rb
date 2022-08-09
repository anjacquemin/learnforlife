class QuestionAnswer < ApplicationRecord
  belongs_to :quizz
  has_many :user_answers
  has_one :theme, through: :quizz
  validates :question, presence: true
  validates :answer, presence: true
end
