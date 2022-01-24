class AddCommunityToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :community_id, :integer
  end
end
