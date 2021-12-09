class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :banned

  def index
    @user = current_user
  end

  def show
    @user = current_user
    @chat_message = ChatMessage.all
  end
end
