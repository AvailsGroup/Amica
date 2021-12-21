class NotificationsController < ApplicationController

  def index
    @users = User.includes(:tags)
    @user = @users.find(current_user.id)
    @notifications = @user.passive_notifications.includes(:visitor, :visited, :post, :comment)
    @notifications.where(checked: false).each do |n|
      n.update!(checked: true)
    end

    @notifications = @notifications.page(params[:page]).per(20)
    @comments = Comment.includes(:user)
  end
end
