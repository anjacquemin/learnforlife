class CreateQuizzProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :quizz_progresses do |t|
      t.references :quizz, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :unlocked

      t.timestamps
    end
  end
end
