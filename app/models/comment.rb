class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :reports

  validates :comment, presence: true, length: { maximum: 300 }

  has_many :notifications, dependent: :destroy
end
