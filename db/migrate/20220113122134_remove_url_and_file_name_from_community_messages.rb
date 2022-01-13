class RemoveUrlAndFileNameFromCommunityMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :community_messages, :file_name, :string
    remove_column :community_messages, :url, :string
  end
end
