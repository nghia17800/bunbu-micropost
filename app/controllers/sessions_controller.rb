class SessionsController < ApplicationController
  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

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
