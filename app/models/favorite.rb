class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :favorite_user, class_name: 'User', optional: true
  belongs_to :community, optional: true

  validates :user_id, uniqueness: { scope: %i[community_id favorite_user_id] }, allow_nil: false
end
