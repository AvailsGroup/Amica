class WhispersController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @users = User.includes(:tags)
    user = @users.find(current_user.id)
    @whispers = user.whispers
    @new_whispers = []
    @whispers.where(checked: false).each do |n|
      @new_whispers.push(n.id)
      n.update!(checked: true)
    end

    @pagenate = @whispers.page(params[:page]).per(20)
    @comments = Comment.includes(:user)
    @notifications = user.passive_notifications.includes(:visitor, :visited, :post, :comment)
    informations = InformationShow.includes(:information, :user)
    information = informations.select { |i| i.user_id == user.id }
    @info_show_count = Information.all.size - information.size
  end

  def show
    @whisper = Whisper.find(params[:id])
    permission
  end

  private

  def permission
    if @whisper.user != current_user
      redirect_to pages_path, notice: "権限がありません。"
    end
  end
end
