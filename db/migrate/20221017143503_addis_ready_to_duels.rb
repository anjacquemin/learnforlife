class AddisReadyToDuels < ActiveRecord::Migration[6.1]
  def change
    add_column :duels, :is_ready, :boolean, default: false
  end
end
