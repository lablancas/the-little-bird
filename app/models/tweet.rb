class Tweet < ActiveRecord::Base
  belongs_to :user
    belongs_to :original_tweet, :class_name => 'Tweet'
    validates_presence_of :user_id, :message, :created_at
    
end
