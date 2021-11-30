class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @posts = Post.all.order(created_at: :desc)
    @create = Post.new
    @user = User.all

  end

  def show
    @post = Post.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
    @user = User.all
  end

  def new
  end

  def create

    #if Post.where(content: params[:posts][:content]).last.userid != nil
    #if Post.where(content: params[:posts][:content]).last.id == current_user.id
    #flash[:alert] = "連続して同じ内容の投稿はできません。"
    #  redirect_to(timelines_path)
    # return
    # end
    # end

    @create = Post.new(post_params)
    @create.userid = current_user.id
    @create.save
    redirect_to(timelines_path)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(timeline_params)
    redirect_to(timelines_path)
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to(timelines_path)
  end

  def search
    @post = params[:q]
    @posts = Post.search_content_for(params[:q]).order(created_at: :desc).page(params[:page]).per(10)
    @user = User.all
  end

  private

  def post_params()
    params.require(:post).permit(:content)
  end
end
