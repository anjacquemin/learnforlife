class Category < ApplicationRecord
  belongs_to :subtheme
  has_one :theme, through: :subtheme
  has_many :category_progresses

  validates :name, presence: true
end
