class AddColumnChatMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :chat_messages, :send_userid, :integer
  end
end
