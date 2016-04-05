class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    redirect_to user_show_path(user.username)
  end

  def destroy
    session.clear
    flash[:success] = "You have been logged out."
    redirect_to root_path
  end
end
