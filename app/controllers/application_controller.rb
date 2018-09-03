class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @user ||= User.find_by(email: session[:email])
  end

  def set_current_user(user:)
    session[:email] = user.email
  end
end
