class Achievement < ApplicationRecord
  belongs_to :user

  def change_rare_like
    update_attribute(:rare_like, true)
  end
end
