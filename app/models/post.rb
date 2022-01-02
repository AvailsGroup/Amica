class Post < ApplicationRecord

  belongs_to :user

  has_many :notifications, dependent: :destroy
  has_many :reports
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content,
            length: { minimum: 1, maximum: 280 }

  scope :search_content_for, ->(query) { where('content like ?', "%#{query}%") }

  has_many :comments, dependent: :destroy

  has_many :mutes, dependent: :destroy

  mount_uploader :image, ImgUploader
end
