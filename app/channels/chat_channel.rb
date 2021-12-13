class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'chat_channel', message: data['message']
    #Message.create! content: data['message']
    #Message.create content: data['message'], user_id: current_user.id, room_id: '1'
  end
end
