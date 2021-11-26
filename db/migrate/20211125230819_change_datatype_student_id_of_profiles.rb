class ChangeDatatypeStudentIdOfProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :student_id, :text, default: '0000000'
  end
end
