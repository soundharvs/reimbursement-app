class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end

  def require_admin
    unless current_user&.role == 1
      redirect_to root_path, alert: "Access denied!"
    end
  end
end
