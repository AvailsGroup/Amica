class CommunityMessage < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates :content, presence: true

  after_create_commit { CommunityMessageBroadcastJob.perform_later self }
end
