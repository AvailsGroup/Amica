class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.integer :user_id, null: false
      t.boolean :niceLv1, default: false
      t.boolean :niceLv2, default: false
      t.boolean :niceLv3, default: false
      t.timestamps
    end
  end
end
