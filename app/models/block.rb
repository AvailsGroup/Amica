class Block < ApplicationRecord
  belongs_to :user
  belongs_to :blocked_user, class_name: 'User'

  validates :user_id, uniqueness: { scope: :blocked_user_id }
end
