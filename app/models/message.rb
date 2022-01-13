class Message < ApplicationRecord
  has_many :room

  has_one_attached :file

  belongs_to :user
  validates :user_id, :content, presence: true

end
