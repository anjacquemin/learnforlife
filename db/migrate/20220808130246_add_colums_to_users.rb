class AddColumsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :hp, :integer, default: 50
    add_column :users, :xp, :integer, default: 0
    add_column :users, :gem, :integer, default: 0
    add_column :users, :gold, :integer, default: 0
    add_column :users, :level, :integer, default: 1
  end
end
