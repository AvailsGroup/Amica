class CommunityMessage < ApplicationRecord
  validates :content, presence: true

  after_create_commit { CommunityMessageBroadcastJob.perform_later self }
end
