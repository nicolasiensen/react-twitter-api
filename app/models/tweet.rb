class Tweet < ApplicationRecord
  validates :uuid, uniqueness: { scope: :user_id }
  validates :uuid, :user_id, presence: true
end
