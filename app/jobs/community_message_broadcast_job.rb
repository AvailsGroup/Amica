class CommunityMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'communities_room_channel', message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render partial: 'communities_room/message', locals: { message: message }
  end
end
