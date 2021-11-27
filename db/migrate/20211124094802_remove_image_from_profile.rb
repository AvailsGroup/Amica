class RemoveImageFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :image, :text
  end
end
