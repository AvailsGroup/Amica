class AddSnsToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :instagram_id, :string
    add_column :profiles, :discord_name, :string
    add_column :profiles, :discord_tag, :integer
  end
end
