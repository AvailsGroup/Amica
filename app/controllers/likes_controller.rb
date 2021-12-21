class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    Like.create(user_id: current_user.id, post_id: params[:timeline_id])
    @like = Post.find_by(id: params[:timeline_id])
    @notification = Notification.new(visitor_id: current_user.id, visited_id: @like.user_id,post_id: params[:timeline_id],action: "like", checked: false)
    @notification.save
    @posts = Post.includes(:user, :likes, :comments)
    @post = @posts.find_by(id: params[:timeline_id])
    @user = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    #redirect_to timelines_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:timeline_id]).destroy
    @like = Post.find_by(id: params[:timeline_id])
    @posts = Post.includes(:user, :likes, :comments)
    if Notification.exists?(visitor_id: current_user.id, visited_id: @like.user_id, post_id: params[:timeline_id], action: "like", checked: false)
      Notification.find_by(visitor_id: current_user.id, visited_id: @like.user_id, post_id: params[:timeline_id], action: "like", checked: false).destroy
    end
    @post = @posts.find_by(id: params[:timeline_id])
    @user = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    #redirect_to timelines_path
  end
end