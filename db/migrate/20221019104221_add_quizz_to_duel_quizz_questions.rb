class AddQuizzToDuelQuizzQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :duel_quizz_questions, :quizz, foreign_key: true
  end
end
