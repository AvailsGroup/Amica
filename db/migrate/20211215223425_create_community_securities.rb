class CreateCommunitySecurities < ActiveRecord::Migration[6.1]
  def change
    create_table :community_securities do |t|
      t.integer :user_id
      t.integer :community_id
      t.text :reason
      t.timestamps
    end
  end
end
