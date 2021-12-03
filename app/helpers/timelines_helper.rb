module TimelinesHelper
  HASHTAG_REGEX = /(?<=\s|　|^)#.+?(?=(　|\s|$))/.freeze

  def link_to_hashtag(content)
    content.gsub(HASHTAG_REGEX) { |hashtag| link_to(hashtag, search_timelines_path(q: hashtag)) }
  end

  def html_with_link_to_hashtag(content)
    # 下の処理でaタグのhref属性を表示できるようにするので、ハッシュタグのaタグ以外が有効にならないように、エスケープしておく。
    html_escaped_content = h(content)
    content_with_hashtags = link_to_hashtag(html_escaped_content)
    # aタグのhref属性以外はサニタイズします。
    # aタグのhref属性はエスケープされずに表示されるようになります。
    sanitize content_with_hashtags, tags: ['a'], attributes: ['href']
  end
end
