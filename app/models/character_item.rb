class CharacterItem < ApplicationRecord
  def self.types
    ["hair", "body", "head", "weapon"]
  end

  def self.set_character_item_lock_or_not(user)
    item_status = {}
    item_status[:unlocked] = {}
    self.types.each { |item_type|
      unlocked_item = user.character_items.where(character_items: {item_type: item_type}).where(user_character_items: {unlocked: true})
      item_status[:unlocked][item_type.to_sym] = unlocked_item
    }

    item_status[:locked] = {}
    self.types.each { |item_type|
      locked_item = user.character_items.where(character_items: {item_type: item_type}).where(user_character_items: {unlocked: false})
      item_status[:locked][item_type.to_sym] = locked_item.to_a
    }

     item_status
  end
end
