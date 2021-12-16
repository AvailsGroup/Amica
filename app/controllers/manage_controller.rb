class ManageController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  before_action :set_community

  def create
    if @community.user_id == current_user.id
      flash[:notice] = "あなたはすでにコミュニティリーダーです。"
      redirect_to(community_path(@community.id))
      return
    end
    if community_ban?(@community)
      CommunityMember.create(user_id: current_user.id, community_id: @community.id)
    else
      flash[:alert] = "あなたはこのコミュニティから参加禁止にされています。"
    end
    redirect_to(community_path(@community.id))
  end

  def destroy
    if @community.user_id == current_user.id
      flash[:notice] = "コミュニティリーダーは抜けることはできません。"
    else
      @cm = CommunityMember.find_by(user_id: current_user.id, community_id: @community.id)
      @cm.destroy
    end
    redirect_to(community_path(@community.id))
  end

  private

  def set_community
    @community = Community.includes(:user, :tags, :community_members, :community_securities, :favorites).find(params[:community_id])
  end

  def community_ban?(community)
    community.community_securities.any? { |c| c.user_id == @user.id }
  end
end
