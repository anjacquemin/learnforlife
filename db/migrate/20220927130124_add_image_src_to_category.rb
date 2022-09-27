class AddImageSrcToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :img_src, :string
  end
end
