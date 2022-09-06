class CreateCharacterItems < ActiveRecord::Migration[6.1]
  def change
    create_table :character_items do |t|
      t.string :item_type
      t.string :img_src
      t.string :name

      t.timestamps
    end
  end
end
