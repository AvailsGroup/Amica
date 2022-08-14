class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
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
    redirect 'follow'
  end

  def latest
    view_parameter
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(30)
    redirect 'latest'
  end

  def pickup
    view_parameter
    @post = @post.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
                 .reject { |p| p.user == current_user }
                 .reject { |p| @user.blocks.any? { |u| u.blocked_user_id == p.user_id } }
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
    @create = Post.new(content: post_params[:content])
    @create.user = current_user
    unless @create.save
      flash[:alert] = '投稿の文字数は1~280文字までです<br/>画像はjpg jpeg png gifのみ対応しています。<br/>画像は10MBまでです。'
      redirect_to(timelines_path)
      return
    end
    @post = Post.find(@create.id)
    unless post_params[:image].nil?
      unless save_image?
        @post.destroy
        flash[:alert] = '画像が破損しているか、容量が大きすぎる可能性があります。<br />画像は10MBまでです。'
      end
    end
    redirect_to(timelines_path)
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
    @report = Report.new
  end

  private

  def view_parameter
    @users = User.includes(:likes, :comments, :tags, :followings, :followers, :passive_relationships, :active_relationships, :blocks)
    @user = @users.find(current_user.id)
    @post = Post.includes(:user, :likes, :comments, :mutes)
    @posts = @post.order(created_at: :desc)
    @posts = @posts.reject { |p| @user.blocks.any? { |u| u.blocked_user_id == p.user_id } }
    @create = Post.new
    @report = Report.new
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def save_image?
    Dir.mkdir("#{Rails.root}/tmp/timeline/") unless File.directory?("#{Rails.root}/tmp/timeline")
    rand = rand(1000..9999)
    @image_name = "#{Time.zone.now.strftime('%Y%m%d%H%M%S')}#{rand}.jpg"
    File.binwrite("#{Rails.root}/tmp/timeline/#{@image_name}", post_params[:image].read)
    # file_check = check_broken_file("#{Rails.root}/tmp/timeline/#{@image_name}")
    # @unless file_check[0] != :unknown && file_check[1] == :clean
    #   File.delete("#{Rails.root}/tmp/timeline/#{@image_name}")
    #   return false
    # end
    f = File.open("#{Rails.root}/tmp/timeline/#{@image_name}")
    begin
      @post.image.attach(io: f, filename: @image_name)
    rescue StandardError
      f.close
      File.delete("#{Rails.root}/tmp/timeline/#{@image_name}")
      return false
    end
    f.close
    File.delete("#{Rails.root}/tmp/timeline/#{@image_name}")
    true
  end


  def redirect(page)
    @page = page
    render 'timelines/index'
  end
end
