class RenameUseridColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :userid, :user_id
  end
end
