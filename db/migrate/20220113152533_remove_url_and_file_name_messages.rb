class RemoveUrlAndFileNameMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :file_name, :string
    remove_column :messages, :url, :string
    rename_column :messages, :image, :file
    remove_column :messages, :file, :string
  end
end
