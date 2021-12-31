class Information < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  has_many :information_shows
end
