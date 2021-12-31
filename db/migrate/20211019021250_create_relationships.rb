class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id # フォローしている側のユーザー (active relationship)
      t.integer :followed_id # フォローされている側のユーザー(passive relationship)
      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 保存するデータの組み合わせが一意になるよう設定
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end