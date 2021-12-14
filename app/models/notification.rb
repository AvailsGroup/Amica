class Notification < ApplicationRecord
  belongs_to :visitor
  belongs_to :visited
  belongs_to :micropost
  belongs_to :comment
end
