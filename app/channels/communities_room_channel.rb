class CommunitiesRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'communities_room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @msg = CommunityMessage.create! content: data['message']
    ActionCable.server.broadcast 'communities_room_channel', @msg
  end

end
