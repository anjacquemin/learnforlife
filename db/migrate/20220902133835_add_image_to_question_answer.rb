class AddImageToQuestionAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :question_answers, :image_src, :string, :default => nil
  end
end
