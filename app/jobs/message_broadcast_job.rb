class MessageBroadcastJob < ApplicationJob
  queue_as :default
  def perform(data)
    ActionCable.server.broadcast 'chat_channel', [data, render_message(data), render_other_message(data)]
    pp render_message(data)
  end

  private

  def render_message(data)
    ApplicationController.renderer.render partial: 'chats/chat_message', locals: { message: data, user: true }
  end

  def render_other_message(data)
    ApplicationController.renderer.render partial: 'chats/chat_message', locals: { message: data, user: false }
  end
end


