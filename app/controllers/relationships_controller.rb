class RelationshipsController < ApplicationController
  def create
    @user = User.find_by(userid: params[:profile_id])
    Relationship.create(follower_id: current_user.id, followed_id: @user.id)
    redirect_to profile_path(params[:profile_id]), notice: "フォローしました!"
  end

  def destroy
    other_user = User.find_by(userid: params[:profile_id])
    current_user.unfollow(other_user)
    redirect_to profile_path(params[:profile_id]), notice: "フォローを解除しました！"
  end

  def edit
    @mates = current_user.matchers
    @user = User.find_by(userid: params[:id])
    Relationship.create(favorite_id: @user.id)
    redirect_to pages_path, notice: "favフォローしました!"
  end
end