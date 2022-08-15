class AddScorePercentageToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :score_percentage, :integer
  end
end
