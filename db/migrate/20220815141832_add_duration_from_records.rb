class AddDurationFromRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :seconds_duration, :integer
    add_column :records, :milliseconds_duration, :integer
  end
end
