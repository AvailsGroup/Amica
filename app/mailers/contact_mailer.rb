class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
  mail to: contact.email, bcc: "avails2022@gmail.com",subject:"【Amica】お問い合わせ受付"
  end

  def report_mail(report)
    @report = report
    @email = report.user.email
    mail to: @email, bcc: "report+avails2022@gmail.com",subject:"【Amica】お問い合わせ受付"
  end
end
