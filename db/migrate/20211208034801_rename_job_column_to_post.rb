class RenameJobColumnToPost < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :job, :image
  end
end
