class CreateDuelAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :duel_answers do |t|
      t.references :duel_quizz_question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :answer
      t.boolean :is_good_answer
      t.string :difficulty

      t.timestamps
    end
  end
end
