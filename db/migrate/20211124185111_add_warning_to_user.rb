class AddWarningToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :warning, :integer,default: 0
  end
end
