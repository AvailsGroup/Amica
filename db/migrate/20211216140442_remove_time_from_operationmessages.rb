class RemoveTimeFromOperationmessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :operationmessages, :time, :datetime
  end
end
