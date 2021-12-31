class InformationShow < ApplicationRecord
  belongs_to :information
  belongs_to :user

  validates :user, uniqueness: { scope: :information }
end
