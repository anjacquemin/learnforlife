class CategoryProgress < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one :theme, through: :category

  validates :unlocked, inclusion: [true, false]

end
