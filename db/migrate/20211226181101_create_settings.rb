class CreateSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.integer :user_id, null: false
      t.boolean :visible_enrolled_year, default: true
      t.timestamps
    end
  end
end
