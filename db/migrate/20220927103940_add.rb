class Add < ActiveRecord::Migration[6.1]
  def change
    add_reference :question_answers, :level, foreign_key: true
  end
end
