class UserCharacterItem < ApplicationRecord
  belongs_to :user
  belongs_to :character_item

  validates :unlocked, inclusion: [true, false]
  validates :bought, inclusion: [true, false]
end
