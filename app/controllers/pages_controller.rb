class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :is_user_favorite?
  helper_method :is_community_favorite?

  def index
    users = User.includes(:favorite, :followers, :passive_relationships, :active_relationships, :followings, :tags)
    @user = users.find(current_user.id)

    @mates = matchers(@user)
    favorite = Favorite.where(user_id: @user.id)
    @favorite_users = favorite.reject { |u| u.favorite_user_id.nil? }.map(&:favorite_user)
    @mates -= @favorite_users
    @mates = @mates.sample(30)

    @communities = Community.includes([:community_members, :tags]).where(id:current_user.community_member.select(:community_id)).order(created_at: :desc)
    @favorite_communities = favorite.reject { |u| u.community_id.nil? }.map(&:community)
    @communities -= @favorite_communities
    @communities = @communities.sample(30)
  end

  def user
    @favorite = Favorite.all
    @users = User.preload(:profile, :favorite, :followers, :followings, :tags)
    @user = @users.find(current_user.id)
    @mates = []
    unless params[:name] == ''
      @user.matchers.each do |u|
        if u.name.downcase.include?(params[:name].downcase) || u.nickname.downcase.include?(params[:name].downcase) || u.userid.downcase.include?(params[:name].downcase)
          @mates.push(u)
        end
      end
    end
  end

  def community
    @favorite = Favorite.all
    @result = []
    @users = User.preload(:tags)
    @user = @users.find(current_user.id)
    @communities = Community.includes([:community_members, :user, :tags]).where(id: current_user.community_member.select(:community_id)).order(created_at: :desc)
    unless params[:name] == ''
      Community.includes([:community_members, :user, :tags]).where(id: current_user.community_member.select(:community_id)).order(created_at: :desc).each do |c|
        @result.push(c) if c.name.downcase.include?(params[:name].downcase)
      end
    end
  end
end
