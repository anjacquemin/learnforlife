class UserCharacterItem < ApplicationRecord
  belongs_to :user
  belongs_to :character_item
end
