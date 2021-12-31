class InformationsController < ApplicationController

  def index
    @users = User.includes(:tags)
    user = @users.find(current_user.id)
    @notifications = user.passive_notifications.includes(:visitor, :visited, :post, :comment)
    @notification = @notifications.where.not(visitor_id: user.id)
    @informations = Information.all
    @information_show = InformationShow.includes(:information, :user)
    @information = @information_show.select { |i| i.user_id == user.id }
    @info_show_count = @informations.size - @information.size
    @pagenate = @informations.page(params[:page]).per(20)
    @pagenate.each do |i|
      unless InformationShow.exists?(user_id: user.id, information_id: i.id)
        InformationShow.create(user_id: user.id, information_id: i.id)
      end
    end

  end

  def show
    @information = Information.find(params[:id])
  end
end
