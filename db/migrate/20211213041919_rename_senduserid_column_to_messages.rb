class RenameSenduseridColumnToMessages < ActiveRecord::Migration[6.1]
  def change
    rename_column :messages,:send_userid,:user_id
  end
end
