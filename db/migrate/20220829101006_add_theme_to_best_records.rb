class AddThemeToBestRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :best_records, :theme, foreign_key: true
  end
end
