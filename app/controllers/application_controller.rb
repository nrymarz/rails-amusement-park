class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def logged_in?
      !!session[:user_id]
  end

  def current_user
      User.find_by_id(session[:user_id])
  end

  def logged_in_as_admin?
      logged_in? && current_user.admin
  end

  def redirect_if_not_admin
    redirect_to root_path if !logged_in_as_admin?
  end
end
