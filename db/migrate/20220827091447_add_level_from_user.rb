class AddLevelFromUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :level, foreign_key: true
  end
end
