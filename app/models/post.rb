class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :likes

  validates :content,
            length: { minimum: 1, maximum: 280 }

  scope :search_content_for, ->(query) { where('content like ?', "%#{query}%") }

  belongs_to :user
  has_many :comments, dependent: :destroy

end
