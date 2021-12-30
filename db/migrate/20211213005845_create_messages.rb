class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :room_id
      t.integer :send_userid
      t.text :content
      t.timestamps
    end
  end
end
