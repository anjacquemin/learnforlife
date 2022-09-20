class AddBoughtToUserCharacterItem < ActiveRecord::Migration[6.1]
  def change
    add_column :user_character_items, :bought, :boolean
  end
end
