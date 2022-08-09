class QuestionAnswer < ApplicationRecord
  belongs_to :quizz
  has_many :user_answers
  validates :question, presence: true
  validates :answer, presence: true
end
