class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  helper_method :following?
  helper_method :liked_by?
  helper_method :matchers
  helper_method :matchers?

  def index
    view_parameter
    @posts = @posts.select { |p| matchers?(@user, p.user) || p.user == current_user }
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    redirect 'friends'
  end

  def follow
    view_parameter
    @posts = @posts.select { |p| following?(@user.followings_list, p.user) || p.user == current_user }
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    redirect  'follow'
  end

  def latest
    view_parameter
    @posts = @post.order(created_at: :desc).page(params[:page]).per(30)
    redirect 'latest'
  end

  def pickup
    view_parameter
    @post = @post.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
                 .reject { |p| p.user == current_user }
    @posts = @post.sort_by { |p| p.likes.size }
    @posts = @posts.reverse
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    redirect 'pickup'
  end

  def show
    @posts = Post.includes(:user, :likes, :comments)
    @post = @posts.find(params[:id])
    @comments = @post.comments.includes(:user)
    @count = @comments.size
    @comments = @comments.order(created_at: :desc).page(params[:page]).per(10)
    @comment = Comment.new
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @report = Report.new
  end

  def create
    @create = Post.new(post_params)
    @create.user = current_user
    flash[:alert] = '投稿の文字数は1~280文字までです<br/>画像はjpg jpeg png gifのみ対応しています。<br/>画像は10MBまでです。' unless @create.save!
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
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @post_m = Post.includes(:user, :likes, :comments)
  end

  private

  def view_parameter
    @post = Post.includes(:user, :likes, :comments)
    @posts = @post.order(created_at: :desc)
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships)
    @user = @users.find(current_user.id)
    @create = Post.new
    @report = Report.new
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def redirect(page)
    @page = page
    render 'timelines/index'
  end
end
