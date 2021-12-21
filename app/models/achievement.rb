class Achievement < ApplicationRecord
  belongs_to :user

  def change_hand_like
    update_attribute(:hand_like, true)
  end

  def change_wink_like
    update_attribute(:wink_like, true)
  end
end
