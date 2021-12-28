class AddColumnUrlToMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :messages,:url,:string
  end
end
