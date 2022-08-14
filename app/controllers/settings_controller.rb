class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def index
    @users = User.includes(:setting)
    @user = @users.find(current_user.id)
  end

  def enrolled_year
    change_enrolled_year
  end

  def student_id
    change_student_id
  end

  private

  def change_enrolled_year
    setting = Setting.find_by(user_id: current_user.id)
    setting.visible_enrolled_year = !setting.visible_enrolled_year
    setting.save
    redirect_to settings_path
  end

  def change_student_id
    setting = Setting.find_by(user_id: current_user.id)
    setting.visible_student_id = !setting.visible_student_id
    setting.save
    redirect_to settings_path
  end

end
