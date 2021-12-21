class AddWinkLikeToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :wink_like, :boolean, default: false
  end
end
