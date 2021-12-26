module RankingHelper

  def rank_count(user, title)
    case title
    when '投稿数' then user.posts.size
    when 'フォロー数' then user.followers.size
    when 'フォロワー数' then user.followings.size
    when '友達数' then user.matchers.size
    when '参加コミュニティ数' then user.community_member.size
    when 'コメント数' then user.comments.size
    else 0
    end
  end

end
