class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def create
    @user = User.find_by(userid: params[:profile_id])
    Relationship.create(follower_id: current_user.id, followed_id: @user.id)
    @notification = Notification.new(visitor_id: current_user.id, visited_id: @user.id,action: "follow",checked: false)
    @notification.save
    redirect_to profile_path(params[:profile_id]), notice: "フォローしました!"
  end

  def destroy
    other_user = User.find_by(userid: params[:profile_id])
    if Favorite.exists?(user_id: current_user.id, favorite_user_id: other_user.id)
      Favorite.find_by(user_id: current_user.id, favorite_user_id: other_user.id).destroy
    end

    current_user.unfollow(other_user)
    redirect_to profile_path(params[:profile_id]), notice: "フォローを解除しました！"
  end

end