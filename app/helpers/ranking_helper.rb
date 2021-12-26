module RankingHelper

  def rank_count(user, title)
    case title
    when '投稿数' then user.posts.size
    else 0
    end
  end

end
