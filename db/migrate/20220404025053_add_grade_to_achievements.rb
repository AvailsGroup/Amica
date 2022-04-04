class AddGradeToAchievements < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :teacher, :boolean, default: false
    add_column :achievements, :scholarship, :boolean, default: false
  end
end
