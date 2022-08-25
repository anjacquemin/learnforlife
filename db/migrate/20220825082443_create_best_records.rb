class CreateBestRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :best_records do |t|
      t.references :quizz_level, null: false, foreign_key: true
      t.references :record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
