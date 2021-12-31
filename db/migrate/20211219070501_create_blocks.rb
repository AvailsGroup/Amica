class CreateBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :blocks do |t|
      t.integer :user_id, null: false
      t.integer :blocked_user_id, null: false
      t.timestamps
    end
  end
end
