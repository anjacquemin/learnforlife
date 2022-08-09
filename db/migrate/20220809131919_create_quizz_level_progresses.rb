class CreateQuizzLevelProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :quizz_level_progresses do |t|
      t.boolean :unlocked
      t.references :user, null: false, foreign_key: true
      t.references :quizz_level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
