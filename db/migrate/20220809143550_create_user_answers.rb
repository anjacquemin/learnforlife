class CreateUserAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_answers do |t|
      t.string :answer
      t.references :quizz_answer, null: false, foreign_key: true
      t.references :question_answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
