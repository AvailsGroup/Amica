class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def create
    @user = User.find_by(userid: params[:profile_id])
    if !blocked?(current_user, @user) && !blocked?(@user, current_user)
      Relationship.create(follower_id: current_user.id, followed_id: @user.id)
      @notification = Notification.create(visitor_id: current_user.id, visited_id: @user.id, action: 'follow')
      flash[:notice] = "フォローしました！"
    else
      flash[:notice] = "エラーが発生しました"
    end
    redirect_to profile_path(params[:profile_id])
  end

  def destroy
    @user = User.find_by(userid: params[:profile_id])
    if Favorite.exists?(user_id: current_user.id, favorite_user_id: @user.id)
      Favorite.find_by(user_id: current_user.id, favorite_user_id: @user.id).destroy
    end

    if Notification.exists?(visitor_id: current_user.id, visited_id: @user.id, action: 'follow', checked: false)
      Notification.find_by(visitor_id: current_user.id, visited_id: @user.id, action: 'follow', checked: false).destroy
    end

    current_user.unfollow(@user)
    redirect_to profile_path(params[:profile_id]), notice: 'フォローを解除しました！'
  end

end