class CommunityMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "communities_room_channel_#{data.community_id}", data
  end
end