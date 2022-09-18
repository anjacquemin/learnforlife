class AddCrownOrSphereToQuizz < ActiveRecord::Migration[6.1]
  def change
    add_column :quizzs, :crown_or_sphere, :string
  end
end
