class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true, length: { maximum: 300 }

  has_many :notifications, dependent: :destroy
end
