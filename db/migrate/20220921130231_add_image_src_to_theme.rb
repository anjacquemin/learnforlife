class AddImageSrcToTheme < ActiveRecord::Migration[6.1]
  def change
    add_column :themes, :image_src, :string
  end
end
