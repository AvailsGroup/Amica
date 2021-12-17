class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
  mail to: contact.email, bcc: "contact+avails2022@gmail.com",subject:"【Amica】お問い合わせ受付"
  end

  def report_mail(report)
    @report = report
    @reported_user = User.find_by(id: report.reported_user_id).nickname
    @reported_content = Post.find_by(id: report.post_id).content
    @email = report.user.email
    mail to: @email, bcc: "report+avails2022@gmail.com",subject:"【Amica】通報受付"
  end
end
