class UsersController < ApplicationController
  before_action :authenticate_user!
    
  def follow
      current_user.follow(User.find(params[:id]))
      redirect_to root_path   
  end

  def unfollow
      current_user.unfollow(User.find(params[:id]))
      redirect_to root_path   
  end
end
