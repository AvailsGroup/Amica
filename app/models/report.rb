class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reported_user ,class_name: "User", optional: true
  belongs_to :post, optional: true
  belongs_to :community, optional: true
  belongs_to :comment, optional: true

  validates :message, length: { minimum: 1 }
  validates :user, uniqueness: { scope: [:reported_user_id,:post_id,:community_id,:comment_id]}
end
