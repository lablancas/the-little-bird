class HomeController < ApplicationController
  def index
      if user_signed_in?
          @tweets = current_user.all_tweets
          @random_users = User.where("id not in (?)", current_user.followees.map(&:id).push(current_user.id)).order("RANDOM()").limit(3)
      else
          redirect_to '/users/sign_in'
      end
  end
end
