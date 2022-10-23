class AddStepToDuels < ActiveRecord::Migration[6.1]
  def change
    add_column :duels, :step, :string
  end
end
