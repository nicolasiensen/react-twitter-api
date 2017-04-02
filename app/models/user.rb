class User < ApplicationRecord
  validates :uuid, presence: true, uniqueness: true
end
