class CreateOperationmessages < ActiveRecord::Migration[6.1]
  def change
    create_table :operationmessages do |t|
      t.string :title
      t.text :body
      t.datetime :time

      t.timestamps
    end
  end
end
