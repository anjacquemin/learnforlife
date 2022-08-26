class AddDealWithToRecord < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :dealt_with, :boolean, default: false
  end
end
