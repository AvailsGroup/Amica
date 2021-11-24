class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  #protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def banned
    if current_user.ban? == true
      sign_out current_user
      flash.alert = "あなたはアカウント停止処分を受けています。"
      redirect_to "/"
    end
  end

  def after_sign_in_path_for(resource)
      pages_path
  end

  private
  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:userid])
    devise_parameter_sanitizer.permit(:account_update, keys: [:userid])
  end



end
