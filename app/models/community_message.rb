class CommunityMessage < ApplicationRecord
  belongs_to :user
  belongs_to :community

  has_many_attached :images
  has_many_attached :files

  validates :content, presence: true

  after_create_commit { CommunityMessageBroadcastJob.perform_later self }
end
