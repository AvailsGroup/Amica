class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail to: contact.email, bcc: "contact+avails2022@gmail.com",subject:"【Amica】お問い合わせ受付"
  end

  def report_mail(report)
    @report = report
    unless report[:post_id]==nil
      @reported_user = User.find_by(id: report.reported_user_id).nickname
      @reported_content = Post.find_by(id: report.post_id).content
    end
    unless report[:community_id]==nil
      @reported_user = Community.find_by(id: report.community_id).name
    end
    unless report[:comment_id]==nil
      @reported_user = User.find_by(id: report.reported_user_id).nickname
      @reported_content = Comment.find_by(id: report.comment_id).comment
    end
    @email = report.user.email
    mail to: @email, bcc: "report+avails2022@gmail.com",subject:"【Amica】通報受付"
  end
end
