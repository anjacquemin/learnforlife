class AddLevelToCharacterItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :character_items, :level, foreign_key: true
  end
end
