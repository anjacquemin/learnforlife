class ThemeLevelProgress < ApplicationRecord
  # Ensure validation of user / theme level presence
  belongs_to :user
  belongs_to :theme_level

  validates :unlocked, inclusion: [true, false]
end
