class AddDebuggerToAchievements < ActiveRecord::Migration[6.1]
  def change
    add_column :achievements, :debugger, :boolean, default: false
  end
end
