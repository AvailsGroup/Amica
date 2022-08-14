class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def create
    @user = User.all
    @post = Post.find(params[:timeline_id])
    @comments = @post.comments.includes(:user)
    @count = @comments.size
    @comments = @comments.order(created_at: :desc).page(params[:page]).per(10)

    @comment = @comments.new(comment_params)
    @comment.user_id = current_user.id
    flash.now[:notice] = @comment.save ? "コメントの投稿に成功しました。" : "コメントの投稿に失敗しました。"

    users = [@post.user, current_user]
    unless @post.user == current_user
      Notification.create(visitor_id: current_user.id, visited_id: @post.user.id, comment_id: @comment.id, action: 'comment')
    end
    @post.comments.each do |c|
      user = c.user
      unless users.include?(user) || @post.mutes.any? { |p| p.user == user }
        users.push(user)
        Notification.create(visitor_id: current_user.id, visited_id: user.id, comment_id: @comment.id, action: 'comment')
      end
    end
    @report = Report.new
    redirect_to(timeline_path(@post.id))
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @user = User.all
    @post = Post.find(params[:timeline_id])
    flash.now[:notice] = 'コメントを削除しました。'
    # TODO: Delete notifications for everyone who sent them
    if Notification.exists?(visitor_id: current_user.id, visited_id: @post.user_id, comment_id: @comment.id, action: 'comment', checked: false)
      Notification.find_by(visitor_id: current_user.id, visited_id: @post.user_id, comment_id: @comment.id, action: 'comment', checked: false).destroy
    end
    @report = Report.new
    redirect_to(timeline_path(@post.id))
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
