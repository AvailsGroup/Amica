class Profile < ApplicationRecord
  belongs_to :user

  validates :school_class, format: { with: /\A[0-9]\z/ }
  validates :number, format: { with: /\A[0-9]{1,2}\z/ }
  validates :student_id, format: { with: /\A[0-9]{7}\z/ }
  validates :intro, length: { minimum: 0, maximum: 300 }, allow_nil: true
  validates :enrolled_year, format: { with: /\A2[0-9]{3}\z/ }
  validates :twitter_id, format: { with: /\A[0-9a-zA-Z_]{1,15}\z/ }, allow_nil: true, allow_blank: true
end
