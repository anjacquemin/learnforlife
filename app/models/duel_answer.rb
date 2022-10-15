class DuelAnswer < ApplicationRecord
  belongs_to :duel_quizz_question
  belongs_to :user
end
