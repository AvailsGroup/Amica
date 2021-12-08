class Achievement < ApplicationRecord
  has_one :user
  has_one :post
  has_one :like
  has_one :community
  has_one :comment
end
