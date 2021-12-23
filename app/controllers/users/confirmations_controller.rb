# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    confirmation_token = params[resource_name][:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token!(confirmation_token)
    if resource.update(confirm_params)
      Achievement.create(user_id: resource.id)
      self.resource = resource_class.confirm_by_token(confirmation_token)
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render action: "show"
    end
  end

  private
  def confirm_params
    params.require(:user).permit(
      :name,
      :nickname,
      :userid,
      :password,
      :password_confirmation,
      profile_attributes:
        %i[grade school_class number student_id enrolled_year]
    )
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
