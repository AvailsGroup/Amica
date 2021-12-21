class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reported_user_id
      t.integer :user_id
      t.string :message
      t.integer :post_id
      t.integer :comment_id
      t.integer :community_id

      t.timestamps
    end
  end
end
