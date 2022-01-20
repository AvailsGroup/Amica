class ChangeDatatypeDiscordTagOfProfile < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :discord_tag, :string
  end
end
