class ChangeDatatypeEnrolledYearOfProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :enrolled_year, :string
  end
end
