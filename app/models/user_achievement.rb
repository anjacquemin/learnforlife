class UserAchievement < ApplicationRecord
  belongs_to :achievement
  belongs_to :user

  validates :unlocked, inclusion: [true, false]

end
