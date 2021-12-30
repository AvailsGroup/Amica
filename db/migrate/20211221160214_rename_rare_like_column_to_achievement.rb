class RenameRareLikeColumnToAchievement < ActiveRecord::Migration[6.1]
  def change
    rename_column :achievements, :rare_like, :hand_like
  end
end
