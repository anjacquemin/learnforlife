class DuelQuizzQuestion < ApplicationRecord
  belongs_to :duel_quizz
  belongs_to :category_id
  belongs_to :question_answer_id
end
