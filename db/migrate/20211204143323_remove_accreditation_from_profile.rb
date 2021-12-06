class RemoveAccreditationFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :accreditation, :text
    remove_column :profiles, :hobby, :text
  end
end
