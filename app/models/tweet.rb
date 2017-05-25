class Tweet < ApplicationRecord
  validates :uuid, uniqueness: { scope: :user_id }
  validates :uuid, :user_id, presence: true

  def archive!
    update_attribute :archived_at, Time.now
  end
end
