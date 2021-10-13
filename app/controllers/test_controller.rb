
class TestController < ApplicationController
  def mail
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]
    inquiry = Inquiry.new(name: @name, message: @content)

    InquiryMailer.send_mail(inquiry)
  end
end
