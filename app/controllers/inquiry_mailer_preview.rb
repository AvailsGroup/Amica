# coding: utf-8
class InquiryMailerPreview < ActionMailer::Preview
  def inquiry
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]
    inquiry = Inquiry.new(name: @name, message: @content, email: @email)

    InquiryMailer.send_mail(inquiry)
  end
end