class CommunityMessage < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates :content, presence: true
end
