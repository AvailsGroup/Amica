class CommunityTag < ApplicationRecord
  belongs_to :community

  validates :tag, length: {minimum: 1,maximum: 10}

end
