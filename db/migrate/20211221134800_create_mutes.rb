class CreateMutes < ActiveRecord::Migration[6.1]
  def change
    create_table :mutes do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
  end
end
