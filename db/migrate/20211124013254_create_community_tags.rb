class CreateCommunityTags < ActiveRecord::Migration[6.1]
  def change
    create_table :community_tags do |t|
      t.integer :community_id
      t.string :tag

      t.timestamps
    end
  end
end
