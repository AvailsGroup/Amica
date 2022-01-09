class CommunityMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "communities_room_channel_#{data.community_id}", [data, render_message(data), render_other_message(data)]
  end

  private

  def render_message(data)
    ApplicationController.renderer.render partial:'communities_room/message', locals: { message: data, user: true }
  end

  def render_other_message(data)
    ApplicationController.renderer.render partial:'communities_room/message', locals: { message: data, user: false }
  end
end