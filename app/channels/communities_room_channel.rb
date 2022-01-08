class CommunitiesRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "communities_room_channel_#{params['room']}"
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @community_msg = CommunityMessage.new(content: data['message'], user_id: current_user.id, community_id: data['community_id'])
    ActionCable.server.broadcast "communities_room_channel_#{@community_msg.community_id}", @community_msg if @community_msg.save
  end

end
