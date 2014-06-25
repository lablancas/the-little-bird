class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
    :default => 'wavatar'
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
    validates_uniqueness_of :username    
    validates_uniqueness_of :email
    
    has_many :tweets, :dependent => :destroy
    has_many :followings, :dependent => :destroy
    has_many :followees, :through => :followings
    
    has_many :favorites, :dependent => :destroy
    
    def followers
        Following.where("followee_id = ?", self.id)
    end
    
    def follow(user)
        following = followings.build(:followee_id => user.id)
        if !following.save
            logger.debug 'User '#{user.email}' already exists in the user's following list.'
        end
    end
    
    def unfollow(user)
        following = followings.where("followee_id = ?", user.id)
        if !following.delete_all
            logger.debug 'An error occurred while trying to unfollow User '#{user.id}' for User '#{self.id}''
        end
    end
    
    def all_tweets
        Tweet.where("user_id in (?)", followees.map(&:id).push(self.id)).order(created_at: :desc)
    end
    
    def favorite(tweet)
        favorite = favorites.build(:user_id => self.id, :tweet_id => tweet.id)
        if !favorite.save
            logger.debug 'User '#{self.id}' has already favorited Tweet '#{tweet.id}' '
        end
    end
    
    def unfavorite(tweet)
        favorite = favorites.where("tweet_id = ?", tweet.id)
        if !favorite.delete_all
            logger.debug 'An error occurred while trying to unfavorite Tweet '#{tweet.id}' for User '#{self.id}''
        end
    end
    
    def is_favorited?(tweet)
        favorites.where("tweet_id = ?", tweet.id).present?
    end
    
    def is_retweet?(tweet)
        tweets.where("original_tweet_id = ?", tweet.id).present?
    end
    
    def is_following?(user)
        followees.where("followee_id = ? ", user.id).present?
    end
    
end
