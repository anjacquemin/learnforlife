class DuelQuizz < ApplicationRecord
  belongs_to :theme
  belongs_to :duel

  has_many :duel_quizz_questions
end
