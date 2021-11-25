class ChangeDataGradeToProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :grade, :text,　default:"学科"
  end
end
