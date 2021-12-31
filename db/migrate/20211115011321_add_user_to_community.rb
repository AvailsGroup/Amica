class AddUserToCommunity < ActiveRecord::Migration[6.1]
  def change
    add_column :communities, :user_id, :integer
  end
end
