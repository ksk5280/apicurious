class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def followers
    @followers = current_user.followers(current_user)
  end
end
