module ApplicationHelper
  require 'uri'

  def link(content)
    URI.extract(content, %w[http https]).uniq.each do |url|
      sub_text = ''
      sub_text << '<a href=' << url << ' target="_blank" rel="noopener">' << url << '</a>'
      content.gsub!(url, sub_text)
    end
    content
  end

  def grade
    [%w[情報処理科1年 情報処理科1年],
     %w[情報処理科2年 情報処理科2年],
     %w[実践IoT1年 実践IoT1年],
     %w[実践IoT2年 実践IoT2年],
     %w[Web技術科1年 Web技術科1年],
     %w[Web技術科2年 Web技術科2年],
     %w[ビジネス科1年 ビジネス科1年],
     %w[ビジネス科2年 ビジネス科2年],
     %w[先端ITシステム1年 先端ITシステム1年],
     %w[先端ITシステム2年 先端ITシステム2年],
     %w[先端ITシステム3年 先端ITシステム3年],
     %w[ITライセンス1年 ITライセンス1年],
     %w[実践AI科1年 実践AI科1年],
     %w[実践AI科2年 実践AI科2年],
     %w[実践AI科3年 実践AI科3年],
     %w[実践AI科4年 実践AI科4年],
     %w[情報セキュリティ学科1年 情報セキュリティ学科1年],
     %w[情報セキュリティ学科2年 情報セキュリティ学科2年],
     %w[情報セキュリティ学科3年 情報セキュリティ学科3年],
     %w[情報セキュリティ学科4年 情報セキュリティ学科4年],
     %w[教員 教員],
     %w[OB OB]]
  end

  def notification_count
    informations = InformationShow.includes(:information, :user)
    information = informations.select { |i| i.user_id == current_user.id }
    information_count = Information.all.size - information.size
    notification = current_user.passive_notifications.where(checked: false).size
    whispers = current_user.whispers.where(checked: false).size
    count = notification + whispers + information_count
    count = '99+' if count > 99
    count
  end

end
