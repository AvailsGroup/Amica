class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def create
    Like.create(user_id: current_user.id, post_id: params[:timeline_id])
    @like = Post.find_by(id: params[:timeline_id])
    unless @like.user_id == current_user.id
      @notification = Notification.new(visitor_id: current_user.id, visited_id: @like.user_id, post_id: params[:timeline_id],action: "like")
      @notification.save
    end
    @posts = Post.includes(:user, :likes, :comments)
    @post = @posts.find_by(id: params[:timeline_id])
    @user = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @report = Report.new
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
    @report = Report.new
  end
end