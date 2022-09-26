class SubthemeProgress < ApplicationRecord
  belongs_to :subtheme
  belongs_to :user

  validates :unlocked, inclusion: [true, false]
end
