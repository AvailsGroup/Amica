class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :is_user_favorite?
  helper_method :is_community_favorite?

  def index
    @user_db = User.includes(:favorite, :followers, :passive_relationships, :active_relationships, :followings, :tags)
    @user = @user_db.find(current_user.id)
    @favorite = Favorite.all

    @mates = matchers(@user)
    @favorite_users = []
    @mates.each do |m|
      if @favorite.any? { |u| u.user_id == @user.id } && @favorite.any? { |u| u.favorite_user_id == m.id }
        @favorite_users.push(m)
      end
    end
    @mates -= @favorite_users
    @mates = @mates.shuffle.first(30)

    @communities = Community.includes([:community_members, :tags]).where(id:current_user.community_member.select(:community_id)).order(created_at: :desc)
    @favorite_communities = []
    @communities.each do |c|
      if @favorite.any? { |u| u.user_id == @user.id } && @favorite.any? { |u| u.community_id == c.id }
        @favorite_communities.push(c)
      end
    end
    @communities -= @favorite_communities
    @communities = @communities.shuffle.first(30)
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

  def faq
    @user = current_user
  end

  protected

  def is_user_favorite?(favorite, user, other_user)
    favorite.any? { |u| u.user_id == user.id } && @favorite.any? { |u| u.favorite_user_id == other_user.id }
  end

  def is_community_favorite?(favorite , user, community)
    favorite.any? { |u| u.user_id == user.id } && favorite.any? { |u| u.community_id == community.id }
  end


end
