class DuelQuizzQuestion < ApplicationRecord
  belongs_to :duel_quizz
  belongs_to :category
  belongs_to :question_answer
  belongs_to :quizz
  has_many :duel_answers
  has_one :duel, through: :duel_quizz
end
