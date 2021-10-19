class RelationshipsController < ApplicationController
  def create
    Relationship.create(follower_id: current_user.id, followed_id: params[:user_id])
    redirect_to user_path(params[:user_id]), notice: "Requested successfully!"
  end

  def destroy
    other_user = User.find(params[:user_id])
    current_user.unfollow(other_user)
    redirect_to user_path(params[:user_id]), notice: "Canceld request"
  end
end