class AddCommunityIdToFavorite < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :community_id, :integer
  end
end
