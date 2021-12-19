module CommunitiesHelper

  def member_link_text(page)
    page != 'member' ? 'メンバー' : '参加禁止にしたメンバー'
  end

  def member_link(page, community)
    page != 'member' ? community_members_path(community.id) : community_banned_member_path(community.id)
  end

  def member_text(page)
    page == 'member' ? 'のメンバー' : 'の参加禁止にしたメンバー'
  end
end
