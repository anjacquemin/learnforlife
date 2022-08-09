class CreateQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :question_answers do |t|
      t.string :question
      t.string :answer
      t.references :quizz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
