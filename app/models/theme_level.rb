class ThemeLevel < ApplicationRecord
  belongs_to :theme

  validates :name, length: { maximum: 10 }
  validates :objective, length: { maximum: 140 }
  validates :level, numericality: { greater_than: 0 }

end
