class RankingController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    get_users
  end

  def post
    get_users
    @users = @users.sort_by { |u| u.posts.size }
    @users = @users.reverse
    @pagenate = Kaminari.paginate_array(@users).page(params[:page]).per(30)
    @title = '投稿数'
    render 'ranking/show'
  end

  def follow
    get_users
    render 'ranking/show'
  end

  def follower
    get_users
    render 'ranking/show'
  end

  def friend
    get_users
    render 'ranking/show'
  end

  def community
    get_users
    render 'ranking/show'
  end

  def comment
    get_users
    render 'ranking/show'
  end

  private

  def get_users
    @users = User.includes(:posts, :comments, :communities, :community_member, :followers, :followings, :tags)
    @users = @users.reject { |u| u.userid.nil? }
    @user = User.find(current_user.id)
  end

end
