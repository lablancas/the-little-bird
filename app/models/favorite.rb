class Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :tweet
    
    validates_uniqueness_of :tweet_id, :scope => :user_id
    validates_presence_of :user_id, :tweet_id
end
