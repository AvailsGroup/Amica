# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:new]

  layout 'home'

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  #def create
  #  super
  #rend

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def new
  #  super
  #  reset_session
  # end

  # DELETE /resource
  def destroy
    delete_user
    reset_session
    flash[:notice] = "退会処理を実行いたしました。Amicaのご利用ありがとうございました。"
    redirect_to "/"
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def delete_user
    current_user.communities.delete_all
    current_user.followings.delete_all
    current_user.followers.delete_all
    current_user.discard
  end
end
