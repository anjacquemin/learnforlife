class DuelQuizzQuestion < ApplicationRecord
  belongs_to :duel_quizz
  belongs_to :category
  belongs_to :question_answer
end
