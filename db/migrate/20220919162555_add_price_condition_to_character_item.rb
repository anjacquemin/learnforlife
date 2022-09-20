class AddPriceConditionToCharacterItem < ActiveRecord::Migration[6.1]
  def change
    add_column :character_items, :price, :integer
    add_column :character_items, :unlocked_condition, :string
  end
end
