class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :password, :current_password, :avatar, :phone_number, :street, :city, :province, :country, :postal_code,)
    end
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :current_password, :avatar, :first_name, :last_name, :phone_number, :street, :city, :province, :country, :postal_code, :user_type )
    end
  end
end
