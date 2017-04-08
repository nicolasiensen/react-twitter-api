class User < ApplicationRecord
  has_many :access_tokens
  validates :uuid, presence: true, uniqueness: true
end
