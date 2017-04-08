class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :uuid
      t.integer :user_id
      t.jsonb :data

      t.timestamps
    end
  end
end
