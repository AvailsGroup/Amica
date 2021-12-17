class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  helper_method :following?
  helper_method :liked_by?
  helper_method :matchers
  helper_method :matchers?

  def index
    view_parameter
    @report = Report.new
  end

  def show
    @post_m = Post.includes(:user, :likes, :comments)
    @post = @post_m.find(params[:id])
    # コメント一覧表示で使用する全コメントデータを代入（新着順で表示）
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(10)
    # コメントの作成
    @comment = Comment.new
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @report = Report.new
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

  def follow
    view_parameter
  end

  def latest
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @post = Post.includes(:user, :likes, :comments)
    @posts = @post.order(created_at: :desc).page(params[:page]).per(30)
    @create = Post.new
  end

  def pickup
    @post = Post.includes(:user, :likes, :comments).where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
    @posts = @post.sort_by { | p | p.likes.size }
    @posts = @posts.reverse
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @create = Post.new
  end

  private

  def view_parameter
    @post = Post.includes(:user, :likes, :comments)
    @posts = @post.order(created_at: :desc).page(params[:page]).per(30)
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @create = Post.new
  end

  def post_params()
    params.require(:post).permit(:content, :image)
  end


end
