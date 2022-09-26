class Character < ApplicationRecord
  belongs_to :user

  validates :body, presence: true
  validates :head, presence: true
  validates :hair, presence: true
end
