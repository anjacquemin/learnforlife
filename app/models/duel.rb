class Duel < ApplicationRecord
  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"
  belongs_to :player_to_play, class_name: "User"
  has_many :duel_quizzs
  has_many :duel_quizzs_questions, through: :duel_quizzs
  has_many :duel_quizz_questions, through: :duel_quizzs
  has_many :duel_theme_choices

  validates :player_1_hp, numericality: { greater_than: 0 }
  validates :player_2_hp, numericality: { greater_than: 0 }
end
