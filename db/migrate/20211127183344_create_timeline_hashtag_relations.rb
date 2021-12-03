class CreateTimelineHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :timeline_hashtag_relations do |t|
      t.references :post, index: true, foreign_key: true
      t.references :hashtag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
