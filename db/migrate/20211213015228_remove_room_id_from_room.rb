class RemoveRoomIdFromRoom < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :room_id, :integer
  end
end
