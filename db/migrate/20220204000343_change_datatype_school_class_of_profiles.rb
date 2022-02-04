class ChangeDatatypeSchoolClassOfProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :profiles, :school_class, :string, default: 0
  end
end
