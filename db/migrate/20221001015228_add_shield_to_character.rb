class AddShieldToCharacter < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :shield, :string
  end
end
