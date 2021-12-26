class RankingController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    get_users
  end

  def post
    get_users
    @users = @users.reject { |u| u.posts.size <= 0 }
    @users = @users.sort_by { |u| u.posts.size }
    adjust_params('投稿数')
    render 'ranking/show'
  end

  def follow
    get_users
    @users = @users.reject { |u| u.followers.size <= 0 }
    @users = @users.sort_by { |u| u.followers.size }
    adjust_params('フォロー数')
    render 'ranking/show'
  end

  def follower
    get_users
    @users = @users.reject { |u| u.followings.size <= 0 }
    @users = @users.sort_by { |u| u.followings.size }
    adjust_params('フォロワー数')
    render 'ranking/show'
  end

  def friend
    get_users
    @users = @users.reject { |u| u.matchers.size <= 0 }
    @users = @users.sort_by { |u| u.matchers.size }
    adjust_params('友達数')
    render 'ranking/show'
  end

  def community
    get_users
    @users = @users.reject { |u| u.community_member.size <= 0 }
    @users = @users.sort_by { |u| u.community_member.size }
    adjust_params('参加コミュニティ数')
    render 'ranking/show'
  end

  def comment
    get_users
    @users = @users.reject { |u| u.comments.size <= 0 }
    @users = @users.sort_by { |u| u.comments.size }
    adjust_params('コメント数')
    render 'ranking/show'
  end

  def member
    @page = params[:page].nil? ? 1 : params[:page]
    @community = Community.includes(:user, :community_members)
    @community = @community.sort_by { |c| c.community_members.size }
    @community = @community.reverse
    @pagenate = Kaminari.paginate_array(@community).page(params[:page]).per(30)
    @title = 'コミュニティ人数'
    render 'ranking/show'
  end

  private

  def get_users
    @users = User.includes(:posts, :comments, :communities, :community_member, :followers, :followings, :tags)
    @users = @users.reject { |u| u.userid.nil? }
    @user = User.find(current_user.id)
    @page = params[:page].nil? ? 1 : params[:page]
  end

  def adjust_params(title)
    @users = @users.reverse
    @pagenate = Kaminari.paginate_array(@users).page(params[:page]).per(30)
    @title = title
  end

end
