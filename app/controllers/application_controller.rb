class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_admin_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin_user
    @current_admin_user ||= User.find(session[:admin_user_id]) if session[:admin_user_id]
  end

  def check_permissions
    redirect_to root_path unless current_user.present? && current_user.is_admin?
  end

  def set_user_session(user)
    session[:user_id] = user.id.to_s
  end

  def set_admin_session(admin)
    session[:admin_user_id] = admin.id.to_s
  end
end
