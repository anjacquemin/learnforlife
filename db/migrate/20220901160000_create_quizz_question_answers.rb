class CreateQuizzQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :quizz_question_answers do |t|
      t.references :quizz, null: false, foreign_key: true
      t.references :question_answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
