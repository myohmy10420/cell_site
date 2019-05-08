require "browser"

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :detect_user_device

  private

  def configure_permitted_parameters
    added_attrs = [:phone, :password, :password_confirmation, :name, :sex, :address, :email, :line, :birthday, :store_id, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def detect_user_device
    if browser.device.mobile?
      request.variant = :phone
    end
  end
end
