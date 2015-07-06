class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :admin) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def admin_only
    unless current_user.admin?
      redirect_to root_url, :alert => "Only admin can access this page"
    end
  end

  def user_only
    unless !current_user.admin?
      redirect_to root_url, :alert => "Only user can access this page"
    end
  end

  def active_user_only
    unless current_user.is_active?
      redirect_to bookings_url, :alert => "Sorry! You are not allowed to place any booking at the moment."
    end
  end
end
