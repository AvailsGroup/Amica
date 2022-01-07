class CommunityMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data, current_user_id)
    current_user = User.find(current_user_id)
    ActionCable.server.broadcast "communities_room_channel_#{data.community_id}", render_message(data, current_user)
  end

  private

  def render_message(data, current_user)
    ApplicationController.renderer.render partial: 'communities_room/message', locals: { message: data, current_user: current_user }
  end
end