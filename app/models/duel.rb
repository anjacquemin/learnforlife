class Duel < ApplicationRecord
  belongs_to :player_1, class_name: "User"
  belongs_to :player_2, class_name: "User"
  belongs_to :player_to_play, class_name: "User"

  validates :player_1_hp, numericality: { greater_than: 0 }
  validates :player_2_hp, numericality: { greater_than: 0 }
end
