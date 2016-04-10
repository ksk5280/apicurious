class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def following
    @following_user = current_user.following(current_user).detect do |follower|
      follower.login == params[:username]
    end
  end
end
