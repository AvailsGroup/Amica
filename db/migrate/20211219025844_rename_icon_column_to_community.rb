class RenameIconColumnToCommunity < ActiveRecord::Migration[6.1]
  def change
    rename_column :communities, :icon, :image
  end
end
