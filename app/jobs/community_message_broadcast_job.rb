class CommunityMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "communities_room_channel_#{data.community_id}", render_message(data)
  end

  private

  def render_message(data)
    ApplicationController.renderer.render partial: 'communities_room/message', locals: { message: data }
  end
end