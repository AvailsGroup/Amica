class InformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def index
    @users = User.includes(:tags)
    user = @users.find(current_user.id)
    @notification_count = user.passive_notifications.where(checked: false).size
    @notification_count = '99+' if @notification_count > 99
    @content = Information.all
    @new_content = InformationShow.includes(:information, :user)
    @information = @new_content.select { |i| i.user_id == user.id }
    @info_show_count = @content.size - @information.size
    @info_show_count = '99+' if @info_show_count > 99
    @pagenate = @content.page(params[:page]).per(20)
    @pagenate.each do |i|
      unless InformationShow.exists?(user_id: user.id, information_id: i.id)
        InformationShow.create(user_id: user.id, information_id: i.id)
      end
    end
    @whispers = user.whispers.where(checked: false).size
    @whispers = '99+' if @whispers > 99
    @page = 'information'
    @path = 'notifications/information'

    render 'notifications/index'
  end

  def show
    @content = Information.find(params[:id])
    render 'notifications/show'
  end
end
