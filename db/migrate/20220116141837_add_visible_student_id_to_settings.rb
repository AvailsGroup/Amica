class AddVisibleStudentIdToSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :settings, :visible_student_id, :boolean, default: true, null: false
  end
end
