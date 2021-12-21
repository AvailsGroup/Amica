class CommentsController < ApplicationController

  def create
    @user = User.all
    @post = Post.find(params[:timeline_id])
    @comments = @post.comments.includes(:user)
    @count = @comments.size
    @comments = @comments.order(created_at: :desc).page(params[:page]).per(10)
    @comment = @comments.new(comment_params)
    @comment.user_id = current_user.id
    users = [@post.user]
    @notification = Notification.create(visitor_id: current_user.id, visited_id: users[0].id, comment_id: @comment.id, action: 'comment')
    @post.comments.each do |c|
      user = c.user
      if user != current_user && !users.include?(user)
        users.push(user)
        @notification = Notification.create(visitor_id: current_user.id, visited_id: user.id, comment_id: @comment.id, action: 'comment')
      end
    end
    flash.now[:notice] = @comment.save ? "コメントの投稿に成功しました。" : "コメントの投稿に失敗しました。"
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
    redirect_to(timeline_path(@post.id))
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
