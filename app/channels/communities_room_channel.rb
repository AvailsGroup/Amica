class CommunitiesRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "communities_room_channel_#{params['room']}"
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @community = CommunityMessage.create(content: data['message'], user_id: current_user.id, community_id: data['community_id'])
    CommunityMessageBroadcastJob.perform_later @community, current_user.id
  end

end
