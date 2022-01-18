class BlockController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def create
    @users = User.includes(:blocks)
    @user = @users.find(params[:profile_id])
    return if current_user?
    Block.create(user_id: current_user.id, blocked_user_id: @user.id)
    destroy_db
    flash[:notice] = "ユーザーをブロックしました"
    redirect_back fallback_location: pages_path
  end

  def destroy
    @users = User.includes(:blocks)
    @user = @users.find(params[:profile_id])
    return if current_user?
    Block.find_by(user_id: current_user.id, blocked_user_id: @user.id).destroy
    flash[:notice] = "ユーザーのブロックを解除しました"
    redirect_back fallback_location: pages_path
  end

  private

  def current_user?
    if @user == current_user
      flash[:alert] = "自分はブロックできません"
      redirect_back fallback_location: profile_path(@user)
      true
    end
    false
  end

  def destroy_db
    if Favorite.exists?(user_id: current_user.id, favorite_user_id: @user.id)
      Favorite.find_by(user_id: current_user.id, favorite_user_id: @user.id).destroy
    end
    if Favorite.exists?(favorite_user_id: current_user.id, user_id: @user.id)
      Favorite.find_by(favorite_user_id: current_user.id, user_id: @user.id).destroy
    end
    if Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
      Relationship.find_by(follower_id: current_user.id, followed_id: @user.id).destroy
    end
    if Relationship.exists?(followed_id: current_user.id, follower_id: @user.id)
      Relationship.find_by(followed_id: current_user.id, follower_id: @user.id).destroy
    end
  end
end
