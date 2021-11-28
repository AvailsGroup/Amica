class Community < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :tag

  validates :name, presence: true
  validates :content, presence: true
end
