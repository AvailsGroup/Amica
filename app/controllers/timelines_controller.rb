class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(30)
    @create = Post.new
    @user = User.all
  end

  def show
    @post = Post.find(params[:id])
    # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(10)
    # コメントの作成
    @comment = Comment.new
    @user = User.all
  end

  def new
  end

  def create
    @create = Post.new(post_params)
    @create.user = current_user
    flash[:alert] = "投稿の文字数は1~280文字までです<br/>画像はjpg jpeg png gifのみ対応しています。<br/>画像は10MBまでです。" unless @create.save!
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
    params.require(:post).permit(:content, :image)
  end
end
