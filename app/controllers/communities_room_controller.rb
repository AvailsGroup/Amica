class CommunitiesRoomController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def show
    @community = Community.find(params[:community_id])
    @messages = @community.community_messages
  end
end
