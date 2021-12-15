class OperationMessagesController < ApplicationController
  def new
    @operationmessage=Operationmessage.new
  end

  def create
    @operationmessage=Operationmessage.new(operationmessages_params)
    @operationmessage.save
    redirect_to request.referer
  end
  private
  def operationmessages_params
    params.require(:text).permit(:title, :body, :time)
  end
end
