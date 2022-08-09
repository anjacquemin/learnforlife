class Record < ApplicationRecord
  belongs_to :user
  belongs_to :quizz_level
  has_one :theme, through: :quizz_level

  validates :completion, inclusion: { in: [1,2,3] }
  validates :crown_or_sphere, inclusion: { in: %w(crown sphere) }
end
