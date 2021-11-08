class AddyearTousers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :year, :integer, default: "0"
    add_column :users, :class, :integer, default: "0"
    add_column :users, :number, :integer, default: "0"
    add_column :users, :studentid, :integer, default: "0000000"
    add_column :users, :accreditation,:text, default: "ここに所持資格を入力"
    add_column :users, :hobby, :text, default: "ここに趣味を入力"
    add_column :users, :image, :string
  end
end
