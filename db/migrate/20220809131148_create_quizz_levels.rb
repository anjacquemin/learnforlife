class CreateQuizzLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :quizz_levels do |t|
      t.references :quizz, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
