class Profile < ApplicationRecord
  belongs_to :user

  attr_accessor :x, :y, :width, :height
  has_one_attached :image
end
