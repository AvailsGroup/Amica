class Post < ApplicationRecord
  belongs_to :user

  validate :image_size

  has_many :notifications, dependent: :destroy
  has_many :reports
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  validates :content,
            length: { minimum: 1, maximum: 280 }

  scope :search_content_for, ->(query) { where('content like ?', "%#{query}%") }

  has_many :comments, dependent: :destroy

  has_many :mutes, dependent: :destroy


  private

  def image_size
    return unless image.attached?

    if image.blob.byte_size > 10.megabytes
      image.purge
      errors.add(:image, "は10MB以内にしてください")
    end
  end


end
