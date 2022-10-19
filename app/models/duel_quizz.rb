class DuelQuizz < ApplicationRecord
  belongs_to :theme
  belongs_to :duel

  has_many :duel_quizz_questions
  has_many :duel_answers, through: :duel_quizz_questions
end
