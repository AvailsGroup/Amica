class OperationMessagesController < ApplicationController
  def index
    @posts=Operationmessage.all
  end

  def show
    @post=Operationmessage.find(params[:id])
  end

  def new
    @post=Operationmessage.new
  end

  def create
    Operationmessage.create(post_params)
    redirect_to operation_messages_path,notice: '投稿しました'
  end
  def edit
    @post =Operationmessage.find(params[:id])
  end

  def update
    @post = Operationmessage.find(params[:id])
    if @post.update(post_params)
      redirect_to operation_messages_path,notice: '更新しました'
    else
      render :new
    end
  end

  def destroy
    @post = Operationmessage.find(params[:id])
    @post.destroy
    redirect_to request.referer,notice: '削除しました'
  end
  private
  def post_params
    params.require(:operationmessage).permit(:title,:content)
  end
  end