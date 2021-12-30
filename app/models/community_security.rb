class CommunitySecurity < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates :community, uniqueness: { scope: :user }
end
