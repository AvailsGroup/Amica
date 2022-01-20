class AddFileColumnToCommunityMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :community_messages, :image, :string
    add_column :community_messages, :file_name, :string
    add_column :community_messages, :url, :string
    add_column :community_messages, :content_type, :string, null: false, default: 'text'
  end
end
