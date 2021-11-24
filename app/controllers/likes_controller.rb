class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    Like.create(user_id: current_user.id, post_id: params[:timeline_id])
    @post = Post.find_by(id: params[:timeline_id])
    @user = User.all
    #redirect_to timelines_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:timeline_id]).destroy
    @post = Post.find_by(id: params[:timeline_id])
    @user = User.all
    #redirect_to timelines_path
  end
end
