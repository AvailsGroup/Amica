class AddBirthdayToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :birthday, :date
    add_column :profiles, :twitter_id, :text
    add_column :profiles, :enrolled_year, :integer
  end
end
