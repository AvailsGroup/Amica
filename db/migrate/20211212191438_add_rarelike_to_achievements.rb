class AddRarelikeToAchievements < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :rare_like, :boolean, default: false
  end
end
