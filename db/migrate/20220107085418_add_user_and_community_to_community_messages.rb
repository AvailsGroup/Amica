class AddUserAndCommunityToCommunityMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :community_messages, :user_id, :integer, null: false
    add_column :community_messages, :community_id, :integer, null: false
  end
end
