class Inquiry < ApplicationRecord
  validates :name, presence: true, allow_blank: false, allow_nil: false
  validates :email, presence: true, allow_blank: false, allow_nil: false
  validates :message, presence: true, allow_blank: false, allow_nil: false
end
