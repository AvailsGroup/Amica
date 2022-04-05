class MailerController < ApplicationController
  layout 'home'

  def new
    @inquiry = Inquiry.new
  end

  def create
    unless verify_recaptcha(message: '')
      @inquiry = Inquiry.new(inquiry_params)
      flash.now[:notice] = "reCAPTCHAにチェックを入れてください"
      render :new
      return
    end
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]
    @contact = Inquiry.new(inquiry_params)
    if @contact.save
      ContactMailer.contact_mail(@contact).deliver
      redirect_to "/", notice:"お問い合わせを送信しました。内容によっては返答にお時間をいただくことがありますが、ご容赦くださいますようよろしくお願いいたします。"
    else
      render :new
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :message, :email)
  end

end
