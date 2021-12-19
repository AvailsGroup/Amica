class BlockController < ApplicationController
  def create
    @users = User.includes[:block]
    @user = @users.find_by(userid: params[:profile_id])
    current_user?
    Block.create(user_id: current_user.id, blocked_user_id: @user.id)
    # TODO: destroy follow and favorite
    # TODO: redirect
  end

  def destroy
    @users = User.includes[:block]
    @user = @users.find_by(userid: params[:profile_id])
    current_user?
    Block.find_by(user_id: current_user.id, blocked_user_id: @user.id).destroy
    # TODO: redirect
  end

  private

  def current_user?
    if @user == current_user
      # TODO: redirect
      return
    end
  end
end
