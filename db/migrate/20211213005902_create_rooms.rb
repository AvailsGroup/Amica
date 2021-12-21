class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :room_id
      t.integer :started_userid
      t.integer :invited_userid
      t.timestamps
    end
  end
end
