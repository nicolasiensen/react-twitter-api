class AccessToken < ApplicationRecord
  validates :token, uniqueness: { scope: :user_id }
  validates :token, :user_id, presence: true
end
