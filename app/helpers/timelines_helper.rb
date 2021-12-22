module TimelinesHelper
  require 'uri'

  def link_to_hashtag(content)
    URI.extract(content, %w[http https]).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      content.gsub!(url, sub_text)
    end
    content.gsub(/(?<=\s|　|^)#.+?(?=(　|\s|$))/.freeze) { |hashtag| link_to(hashtag, search_timelines_path(q: hashtag)) }
  end

  def html_with_link_to_hashtag(content)
    html_escaped_content = h(content)
    content_with_hashtags = link_to_hashtag(html_escaped_content)
    sanitize content_with_hashtags, tags: ['a'], attributes: ['href']
  end

  def push(user)
    case rand(1..65536)
    when 1
      user.achievement.change_hand_like
      '<i class="fas fa-hand-holding-heart red"></i>' # 1/65536
    when 2..6
      user.achievement.change_wink_like
      '<i class="fas fa-laugh-wink"></i>' # 1/16384
    when 11..19 then '<i class="fab fa-yarn"></i>' # 1/8192
    when 20..28 then '<i class="fab fa-node-js"></i>' # 1/8192
    when 29..37 then '<i class="fab fa-yarn"></i>' # 1/8192
    when 38..103 then '<i class="fas fa-rocket"></i>' # 1/1000
    when 1000..1261 then '<i class="fas fa-mug-hot"></i>' # 1/250
    when 2000..2654 then '<i class="fas fa-heartbeat"></i>' # 1/100
    else '<i class="fas fa-heart"></i>'
    end
  end
end
