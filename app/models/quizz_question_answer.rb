class QuizzQuestionAnswer < ApplicationRecord
  belongs_to :quizz
  belongs_to :question_answer
  has_one :theme, through: :quizz
  has_many :flashcards, through: :question_answer


end
