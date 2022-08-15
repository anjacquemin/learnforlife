class RemoveDurationFromRecords < ActiveRecord::Migration[6.1]
  def change
    remove_column :records, :duration, :time
  end
end
