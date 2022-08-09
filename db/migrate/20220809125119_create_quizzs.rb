class CreateQuizzs < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzs do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.integer :ordering

      t.timestamps
    end
  end
end
