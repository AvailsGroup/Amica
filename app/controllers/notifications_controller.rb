class NotificationsController < ApplicationController

  def index
    @users = User.includes(:tags)
    @user = @users.find(current_user.id)
    @notifications = @user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update!(checked: true)
    end

    @notifications = @notifications.page(params[:page]).per(20)
    @comments = Comment.includes(:user)
  end
end
