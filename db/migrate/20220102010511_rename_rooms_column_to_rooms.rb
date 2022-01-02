class RenameRoomsColumnToRooms < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :started_userid, :started_user_id
    rename_column :rooms, :invited_userid, :invited_user_id
  end
end
