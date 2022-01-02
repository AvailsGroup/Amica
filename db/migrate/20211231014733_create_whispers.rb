class CreateWhispers < ActiveRecord::Migration[6.1]
  def change
    create_table :whispers do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
