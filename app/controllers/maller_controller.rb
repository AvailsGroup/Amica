class MallerController < ApplicationController
  def new
    @inquiry = Inquiry.new
    render layout: 'home'
    flash.now[:notice] = 'test'
  end

  def create
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]

    @contact = Inquiry.new(inquiry_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to "/contact", notice:"送信しました"
    else
      render :new
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name,:message,:email)
  end
end
