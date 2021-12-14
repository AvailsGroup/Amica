class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, null: false, foreign_key: true
      t.references :visited, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
