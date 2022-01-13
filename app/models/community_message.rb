class CommunityMessage < ApplicationRecord
  belongs_to :user
  belongs_to :community

  has_one_attached :file

  validates :content, presence: true

  after_create_commit { CommunityMessageBroadcastJob.perform_later self }
end
