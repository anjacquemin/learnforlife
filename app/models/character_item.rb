class CharacterItem < ApplicationRecord
  belongs_to :level, optional: true

  validates :name, presence: true
  validates :item_type, presence: true
  validates :img_src, presence: true
  validates :unlocked_condition, presence: true

  def self.types
    ["hair", "body", "head", "helmet", "weapon", "shield"]
  end

  def self.set_character_item_lock_or_not(user)
    item_status = {}
    item_status[:bought] = {}
    self.types.each { |item_type|
      bought_item = user.character_items.where(character_items: {item_type: item_type}).where(user_character_items: {bought: true})
      item_status[:bought][item_type.to_sym] = bought_item
    }

    item_status[:unbought] = {}
    self.types.each { |item_type|
      unbought_item = user.character_items.where(character_items: {item_type: item_type}).where(user_character_items: {bought: false})
      item_status[:unbought][item_type.to_sym] = unbought_item.to_a
    }

     item_status
  end
end
