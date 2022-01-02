class AddUserToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :userid, :integer
  end
end
