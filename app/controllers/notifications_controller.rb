class NotificationsController < ApplicationController

  def index
    @users = User.includes(:tags)
    @user = @users.find(current_user.id)
    @notifications = @user.passive_notifications.includes(:visitor, :visited, :post, :comment)
    @new_notification = []
    @notifications.where(checked: false).each do |n|
      @new_notification.push(n.id)
      n.update!(checked: true)
    end

    @pagenate = @notifications.page(params[:page]).per(20)
    @comments = Comment.includes(:user)
    @notification = @notifications.where.not(visitor_id: current_user.id)
  end
end
