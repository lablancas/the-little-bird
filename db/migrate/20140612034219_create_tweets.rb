class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
        t.references :user, index: true, :null => false
        t.integer :original_tweet_id, index: true, :null => true
      t.string :message, :null => false
      t.datetime :created_at, :null => false
    end
  end
end
