class AddNiceToAchievement < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements,:niceLv1,:boolean,:default => false
    add_column :achievements,:niceLv2,:boolean,:default => false
    add_column :achievements,:niceLv3,:boolean,:default => false
  end
end
