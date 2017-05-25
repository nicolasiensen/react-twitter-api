class AddArchivedAtToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :archived_at, :datetime
  end
end
