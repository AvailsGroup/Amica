class OperationMessagesController < ApplicationController
  def index
    @posts=Operationmessage.all
  end

  def show
    @post=Operationmessage.find(params[operation_messages.id])
  end

  def new
    @post=Operationmessage.new
  end

  def create
    Operationmessage.create(post_params)
    redirect_to operation_messages_path,notice: '投稿しました'
  end

  private
  def post_params
    params.require(:operationmessage).permit(:title,:content)
  end
  end