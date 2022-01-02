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
    informations = InformationShow.includes(:information, :user)
    information = informations.select { |i| i.user_id == user.id }
    @info_show_count = Information.all.size - information.size
    @whispers = @content.where(checked: false).size
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
