class ManageController < ApplicationController
  before_action :authenticate_user!
  before_action :banned
  before_action :set_community

  def create
    if @community.user_id == current_user.id
      flash[:notice] = "あなたはすでにコミュニティリーダーです。"
    else
      CommunityMember.create(user_id: current_user.id, community_id: @community.id)
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
    @community = Community.find(params[:community_id])
  end
end
