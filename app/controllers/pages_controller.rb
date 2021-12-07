class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  helper_method :is_user_favorite?
  helper_method :is_community_favorite?

  def index
    @user = User.includes(:profile, :favorite, :followers,:followings, :tags).find(current_user.id)
    @favorite = Favorite.includes(:user, :favorite_user)
    @mates = @user.followings & @user.followers
    @favorite_users = @mates.select { |e| @favorite.where(user_id: @user.id, favorite_user_id: e.id).size == 1 }
    @communities = community_contents
    @favorite_communities = @community.select{ |e| @favorite.where(user_id: @user.id, community_id: e.id).size == 1 }
  end

  def show
    @user = current_user
  end

  def user
    @mates = []
    unless params[:name] == ''
      current_user.matchers.each do |u|
        if u.name.downcase.include?(params[:name].downcase) || u.nickname.downcase.include?(params[:name].downcase) || u.userid.downcase.include?(params[:name].downcase)
          @mates.push(u)
        end
      end
    end
  end

  def community
    @result = []
    unless params[:name] == ''
      community_contents.each do |c|
        @result.push(c) if c.name.downcase.include?(params[:name].downcase)
      end
    end
  end

  protected

  def is_user_favorite?(favorite, user ,other_user)
    favorite.exists?(user_id:user.id,favorite_user_id:other_user.id)
  end

  def is_community_favorite?(favorite ,user ,other_user)
    favorite.exists?(user_id:user.id,community_id:other_user.id)
  end

  def matchers(user)
    user.followings & user.followers
  end

  private

  def community_contents
    @community = Community.includes([:community_members, :tags,:taggings]).where(id:current_user.community_member.select(:community_id)).order(created_at: :desc)
  end



end
