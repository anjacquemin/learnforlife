class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quizz_level, null: false, foreign_key: true
      t.time :duration
      t.integer :completion
      t.string :crown_or_sphere

      t.timestamps
    end
  end
end
