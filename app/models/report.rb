class Report < ApplicationRecord
  belongs_to :user
  has_one :post
  has_one :community
  validates :user, uniqueness: { scope: :post }
end
