class AddQuizzAnswerToRecords < ActiveRecord::Migration[6.1]
  def change
    add_reference :records, :quizz_answer, foreign_key: true
  end
end
