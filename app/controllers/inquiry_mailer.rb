# coding: utf-8
class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)

    @inquiry = inquiry
    mail(
      from: @inquiries.email,
      to:   'avails2022@gmail.com',
      subject: 'お問い合わせ通知'
    )
  end
end
