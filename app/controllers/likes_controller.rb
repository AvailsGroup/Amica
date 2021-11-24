class LikesController < ApplicationController

  def create
    Like.create(user_id: current_user.id, post_id: params[:timeline_id])
    redirect_to timelines_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:timeline_id]).destroy
    redirect_to timelines_path
  end
end
