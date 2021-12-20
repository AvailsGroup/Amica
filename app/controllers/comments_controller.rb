class CommentsController < ApplicationController
  def create
    @user = User.all
    @post = Post.find(params[:timeline_id])

    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @notification = Notification.new(visitor_id: current_user.id, visited_id: @post.user_id,comment_id: @comment.id,action: "comment",checked: false)
    @notification.save
    flash.now[:notice] = @comment.save ? "コメントの投稿に成功しました。" : "コメントの投稿に失敗しました。"
    render "comments/index"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = "コメントを削除しました。"
    @user = User.all
    @post = Post.find(params[:timeline_id])
    render "comments/index"
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
