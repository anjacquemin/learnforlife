class AddOrderingToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :ordering, :integer
  end
end
