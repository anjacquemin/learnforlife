class RemoveReference < ActiveRecord::Migration[6.1]
  def change
    remove_reference :quizz_answers, :quizz, foreigne_key: true, index: false
  end
end
