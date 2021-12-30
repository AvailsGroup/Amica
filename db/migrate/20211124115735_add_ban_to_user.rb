class AddBanToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ban, :boolean, default: "false"
  end
end
