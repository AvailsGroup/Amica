class CommunityMember < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates_uniqueness_of :community_id, scope: :user_id
end
