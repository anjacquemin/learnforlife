class CreateLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :levels do |t|
      t.integer :level
      t.integer :required_xp
      t.integer :beginning_year
      t.string :period
      t.string :sub_period
      t.string :social_type

      t.timestamps
    end
  end
end
