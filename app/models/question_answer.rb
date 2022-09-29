class QuestionAnswer < ApplicationRecord
  belongs_to :level, optional: true
  has_many :user_answers
  has_many :quizz_question_answers
  has_many :quizzs, class_name: :Quizz, through: :quizz_question_answers
  has_many :flashcards
  has_many :suggested_answers
  validates :question, presence: true
  validates :answer, presence: true
end
