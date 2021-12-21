class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    Like.create(user_id: current_user.id, post_id: params[:timeline_id])
    @posts = Post.includes(:user, :likes, :comments)
    @post = @posts.find_by(id: params[:timeline_id])
    @user = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @report = Report.new
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:timeline_id]).destroy
    @posts = Post.includes(:user, :likes, :comments)
    @post = @posts.find_by(id: params[:timeline_id])
    @user = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @report = Report.new
  end
end
