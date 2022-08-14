class CommunitiesSecurityController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def create
    @users = User.includes(:community_member, :tags)
    @user = @users.find(params[:id])
    @community = Community.includes(:user, :tags, :community_members, :community_securities).find(params[:community_id])
    @community.community_securities.create(user_id: params[:id], community_id: params[:community_id])
    if @community.community_members.any? { |m| m.user_id == @user.id }
      @cm = CommunityMember.find_by(user_id: @user.id, community_id: @community.id)
      @cm.destroy
      if Favorite.exists?(user_id: @user.id, community_id: @community.id)
        Favorite.find_by(user_id: @user.id, community_id: @community.id).destroy
      end
    end
    flash[:notice] = "ユーザーを参加禁止にしました。"
    redirect_to(community_members_path)
  end

  def destroy
    @users = User.includes(:community_member, :tags)
    @user = @users.find(params[:id])
    @community = Community.includes(:user, :tags, :community_members, :community_securities).find(params[:community_id])
    if @community.community_securities.exists?(user_id: params[:id], community_id: params[:community_id])
      @community.community_securities.find_by(user_id: params[:id]).destroy
    end
    flash[:notice] = "ユーザーの参加禁止を解除しました。"
    redirect_to(community_banned_member_path)
  end
end
