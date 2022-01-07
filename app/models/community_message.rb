class CommunityMessage < ApplicationRecord
  validates :content, presence: true
end
