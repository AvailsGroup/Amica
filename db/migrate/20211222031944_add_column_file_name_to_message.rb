class AddColumnFileNameToMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :messages ,:file_name,:string
  end
end
