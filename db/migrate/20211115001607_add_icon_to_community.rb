class AddIconToCommunity < ActiveRecord::Migration[6.1]
  def change
    add_column :communities, :icon, :text
  end
end
