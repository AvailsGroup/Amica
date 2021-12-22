class BlockController < ApplicationController
  def create
    @users = User.includes(:blocks)
    @user = @users.find(params[:profile_id])
    current_user?
    Block.create(user_id: current_user.id, blocked_user_id: @user.id)
    # TODO: destroy follow and favorite
    flash[:notice] = "ユーザーをブロックしました"
    redirect_back fallback_location: pages_path
  end

  def destroy
    @users = User.includes(:blocks)
    @user = @users.find(params[:profile_id])
    current_user?
    Block.find_by(user_id: current_user.id, blocked_user_id: @user.id).destroy
    flash[:notice] = "ユーザーのブロックを解除しました"
    redirect_back fallback_location: pages_path
  end

  private

  def current_user?
    if @user == current_user
      # TODO: redirect
      nil
    end
  end
end
