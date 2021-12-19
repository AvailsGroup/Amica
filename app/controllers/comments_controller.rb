class CommentsController < ApplicationController
  def create
    @user = User.all
    @post = Post.find(params[:timeline_id])
    if params[:comment][:comment].nil? || params[:comment][:comment] == ''
      return
    end
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    flash.now[:notice] = @comment.save ? 'コメントの投稿に成功しました。' : 'コメントの投稿に失敗しました。'
    @count = @post.comments.size
    render 'comments/index'
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash.now[:notice] = 'コメントを削除しました。'

    @user = User.all
    @post = Post.find(params[:timeline_id])
    @count = @post.comments.size
    render 'comments/index'
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
