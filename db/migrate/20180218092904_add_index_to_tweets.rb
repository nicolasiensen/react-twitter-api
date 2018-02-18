class AddIndexToTweets < ActiveRecord::Migration[5.1]
  def change
    add_index :tweets, [:uuid, :user_id], unique: true
  end
end
