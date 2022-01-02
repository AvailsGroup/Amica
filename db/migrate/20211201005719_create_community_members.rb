class CreateCommunityMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :community_members do |t|
      t.references :user, foreign_key: true, null: false
      t.references :community, foreign_key: true, null: false

      t.timestamps
    end
  end
end
