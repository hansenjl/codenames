class ApplicationController < ActionController::Base

  def redirect_if_logged_in
    redirect_to games_path if logged_in?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end
