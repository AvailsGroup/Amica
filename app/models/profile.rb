class Profile < ApplicationRecord
  belongs_to :user

  attr_accessor :x, :y, :width, :height
  has_one_attached :image

  validates :school_class, format: { with: /\A[0-9]\z/ }
  validates :number, format: { with: /\A[0-9]{1,2}\z/ }
  validates :student_id, format: { with: /\A[0-9]{7}\z/ }
end
