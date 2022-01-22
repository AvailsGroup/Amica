class InformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @users = User.includes(:tags)
    user = @users.find(current_user.id)
    @notification_count = user.passive_notifications.where(checked: false).size
    @content = Information.all
    @new_content = InformationShow.includes(:information, :user)
    @information = @new_content.select { |i| i.user_id == user.id }
    @info_show_count = @content.size - @information.size
    @pagenate = @content.page(params[:page]).per(20)
    @pagenate.each do |i|
      unless InformationShow.exists?(user_id: user.id, information_id: i.id)
        InformationShow.create(user_id: user.id, information_id: i.id)
      end
    end
    @whispers = user.whispers.where(checked: false).size
    @page = 'information'
    @path = 'notifications/information'

    render 'notifications/index'
  end

  def show
    @content = Information.find(params[:id])
    render 'notifications/show'
  end
end
