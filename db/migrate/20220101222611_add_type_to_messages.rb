class AddTypeToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :content_type, :string, default: 'text'
  end
end
