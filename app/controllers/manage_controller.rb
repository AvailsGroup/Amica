class ManageController < ApplicationController
  before_action :authenticate_user!
  before_action :login_limit
  before_action :banned

  def create
    @community = Community.includes(:user, :tags, :community_members, :community_securities, :favorites).find(params[:community_id])
    if @community.user_id == current_user.id
      flash[:notice] = "あなたはすでにコミュニティリーダーです。"
      redirect_to(community_path(@community.id))
      return
    end
    @user = current_user
    if community_ban?(@community)
      flash[:alert] = "あなたはこのコミュニティから参加禁止にされています。"
    else
      CommunityMember.create(user_id: current_user.id, community_id: @community.id)
    end
    redirect_to(community_path(@community.id))
  end

  def destroy
    @community = Community.includes(:user, :tags, :community_members, :community_securities, :favorites).find(params[:community_id])
    if @community.user_id == current_user.id
      flash[:notice] = "コミュニティリーダーは抜けることはできません。もし抜ける場合はリーダー権限をメンバー一覧から譲渡してください"
    else
      @cm = CommunityMember.find_by(user_id: current_user.id, community_id: @community.id)
      @cm.destroy
      if Favorite.exists?(user_id: current_user.id, community_id: @community.id)
        Favorite.find_by(user_id: current_user.id, community_id: @community.id).destroy
      end
    end
    redirect_to(community_path(@community.id))
  end

  private

  def community_ban?(community)
    community.community_securities.any? { |c| c.user_id == @user.id }
  end
end
