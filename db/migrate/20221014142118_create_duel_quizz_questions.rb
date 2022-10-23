class CreateDuelQuizzQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :duel_quizz_questions do |t|
      t.references :duel_quizz, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :question_answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
