class Profile < ApplicationRecord
  belongs_to :user

  validates :school_class, format: { with: /\A[0-9]\z/ }
  validates :number, format: { with: /\A[0-9]{1,2}\z/ }
  validates :student_id, format: { with: /\A[0-9]{7}\z/ }
  validates :intro, length: { minimum: 0, maximum: 300 }, allow_nil: true
end
