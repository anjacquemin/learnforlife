class CreateSuggestedAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :suggested_answers do |t|
      t.string :answer
      t.references :question_answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
