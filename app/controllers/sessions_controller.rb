class SessionsController < ApplicationController
  def omniauth
    user = User.create_from_omniauth(auth)
    if user.valid?
      session[:user_id] = user.id
      user = User.find_by_id(user.id)
      redirect_to user
    else
      flash[:message] = user.errors.full_messages.join(", ")
      redirect_to login_path
    end
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end
