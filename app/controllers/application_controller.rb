class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :password, :current_password, :avatar, :phone_number, :address, :gender,:user_type)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :current_password, :avatar, :first_name, :last_name, :phone_number, :address, :gender, :user_type )
    end
  end
end
