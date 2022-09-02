class AddCrownOrSphereToQuizzLevels < ActiveRecord::Migration[6.1]
  def change
    add_column :quizz_levels, :crown_or_sphere, :string
  end
end
