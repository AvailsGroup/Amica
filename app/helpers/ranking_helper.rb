module RankingHelper

  def rank_count(user, community, title)
    case title
    when '投稿数' then user.posts.size
    when 'フォロー数' then user.followings.size
    when 'フォロワー数' then user.followers.size
    when '友達数' then user.matchers.size
    when '参加コミュニティ数' then user.community_member.size
    when 'コメント数' then user.comments.size
    when 'コミュニティ人数' then community.community_members.size
    else 0
    end
  end

end
