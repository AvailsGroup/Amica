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
  end

  def new
  end

  def create
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

  private

  def post_params()
    params.require(:post).permit(:content)
  end
end
