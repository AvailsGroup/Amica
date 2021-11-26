class Post < ApplicationRecord
  has_many :likes

  validates :content,
            length: { minimum: 1, maximum: 280 }
end
