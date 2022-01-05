class CreateCommunityMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :community_messages do |t|
      t.text :content

      t.timestamps
    end
  end
end
