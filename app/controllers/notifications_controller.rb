class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @users = User.includes(:tags)
    user = @users.find(current_user.id)
    notifications = user.passive_notifications.includes(:visitor, :visited, :post, :comment)
    @new_content = []
    notifications.where(checked: false).each do |n|
      @new_content.push(n.id)
      n.update!(checked: true)
    end

    @pagenate = notifications.page(params[:page]).per(20)
    @comments = Comment.includes(:user)
    @content = notifications.where.not(visitor_id: user.id)
    @notification_count = notifications.where(checked: false).size
    informations = InformationShow.includes(:information, :user)
    information = informations.select { |i| i.user_id == user.id }
    @info_show_count = Information.all.size - information.size
    @whispers = user.whispers.where(checked: false).size
    @page = 'notification'
    @path = 'notifications/notification'
    render 'notifications/index'
  end
end
