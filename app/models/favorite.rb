class Favorite < ApplicationRecord

  validates :user_id, uniqueness: { scope: %i[community_id favorite_user_id] }
end
