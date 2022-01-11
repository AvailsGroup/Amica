class CommunitiesRoomController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def show
    @community = Community.find(params[:community_id])
    unless current_user.community_member.any? { |c| c.community_id == @community.id }
      redirect_back fallback_location: communities_path, notice: "コミュニティに参加していません"
    end
    @messages = @community.community_messages
    @pagenate = @messages.order(updated_at: :desc).page(params[:page]).per(50)
  end
end
