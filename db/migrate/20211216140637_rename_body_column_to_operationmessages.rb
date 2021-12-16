class RenameBodyColumnToOperationmessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :operationmessages,:body,:content
  end
end
