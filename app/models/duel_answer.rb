class DuelAnswer < ApplicationRecord
  belongs_to :duel_quizz_question
  belongs_to :user
  has_one :duel, through: :duel_quizz_question
  has_one :duel_quizz, through: :duel_quizz_question
  has_one :question_answer, through: :duel_quizz_question
end
