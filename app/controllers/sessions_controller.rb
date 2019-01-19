class SessionsController < ApplicationController

  def welcome
    redirect_if_logged_in
  end

  def new
    redirect_if_logged_in
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to games_path
    else
      flash[:alert] = "Invalid login, please try again."
      redirect_to login_path
    end
  end

  def omniauth
  end

   def destroy
    session.delete :user_id
    @current_user = nil
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end