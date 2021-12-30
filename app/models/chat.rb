class Chat < ApplicationRecord
  belongs_to :room
  has_many :messages, dependent: :destroy
  has_many :users
end
