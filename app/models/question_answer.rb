class QuestionAnswer < ApplicationRecord
  has_many :user_answers
  has_many :quizz_question_answers
  has_many :quizzs, class_name: :Quizz, through: :quizz_question_answers
  has_many :flashcards
  validates :question, presence: true
  validates :answer, presence: true
end
