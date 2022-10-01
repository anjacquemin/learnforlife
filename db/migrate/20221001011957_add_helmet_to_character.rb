class AddHelmetToCharacter < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :helmet, :string
  end
end
