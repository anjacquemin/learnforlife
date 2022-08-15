class AddReference < ActiveRecord::Migration[6.1]
  def change
    add_reference :quizz_answers, :quizz_level, foreign_key: true
  end
end
