class SettingsController < ApplicationController
  def index
    @users = User.includes(:setting)
    @user = @users.find(current_user.id)
  end

  def enable_enrolled_year
    change_enrolled_year
  end

  def disable_enrolled_year
    change_enrolled_year
  end

  def enable_student_id
    change_student_id
  end

  def disable_student_id
    change_student_id
  end

  private

  def change_enrolled_year
    setting = Setting.find_by(user_id: current_user.id)
    setting.visible_enrolled_year = setting.visible_enrolled_year ? false : true
    setting.save
    redirect_to settings_path
  end

  def change_student_id
    setting = Setting.find_by(user_id: current_user.id)
    setting.visible_student_id = setting.visible_student_id ? false : true
    setting.save
    redirect_to settings_path
  end

end
