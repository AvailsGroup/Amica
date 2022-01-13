class RenameImageColumnToCommunityMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :community_messages, :image, :file
  end
end