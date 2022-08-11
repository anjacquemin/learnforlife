class Subtheme < ApplicationRecord
  belongs_to :theme_level
  has_many :subtheme_progresses
  has_many :categories, class_name: :Category
  has_one :theme, through: :theme_level

  validates :name, presence: true
end
