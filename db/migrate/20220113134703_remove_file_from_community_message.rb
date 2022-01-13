class RemoveFileFromCommunityMessage < ActiveRecord::Migration[6.1]
  def change
    remove_column :community_messages, :file, :string
  end
end
