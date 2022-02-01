class WhispersController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @users = User.includes(:tags)
    user = @users.find(current_user.id)
    @content = user.whispers
    @new_content = []
    @content.where(checked: false).each do |n|
      @new_content.push(n.id)
      n.update!(checked: true)
    end
    @pagenate = @content.page(params[:page]).per(20)
    @comments = Comment.includes(:user)
    @notification_count = user.passive_notifications.where(checked: false).size
    @notification_count = '99+' if @notification_count > 99
    informations = InformationShow.includes(:information, :user)
    information = informations.select { |i| i.user_id == user.id }
    @info_show_count = Information.all.size - information.size
    @info_show_count = '99+' if @info_show_count > 99
    @whispers = @content.where(checked: false).size
    @whispers = '99+' if @whispers > 99
    @page = 'whisper'
    @path = 'notifications/whisper'

    render 'notifications/index'
  end

  def show
    @content = Whisper.find(params[:id])
    permission
    render 'notifications/show'
  end

  private

  def permission
    if @content.user != current_user
      redirect_to pages_path, notice: "権限がありません。"
    end
  end
end
