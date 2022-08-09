class CreateQuizzAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :quizz_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quizz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
