class TweetsController < ApplicationController
  before_action :authenticate_user!
    
  def create
      tweet = current_user.tweets.build(tweet_params)
      tweet.created_at = Time.now # HACK
      tweet.save!
      redirect_to root_path       
  end

  def destroy
      Tweet.find(params[:id]).destroy!
      redirect_to root_path       
  end
    
  def retweet
      # TODO
      redirect_to root_path
  end
    
    def favorite
        current_user.favorite(Tweet.find(params[:id]))
        redirect_to root_path
    end
    
    def unfavorite
        current_user.unfavorite(Tweet.find(params[:id]))
        redirect_to root_path
    end
    
  private

  def tweet_params
      params.require(:tweet).permit(:message)
  end
end
