class ChangeDatatypeImageOfCommunity < ActiveRecord::Migration[6.1]
  def change
    change_column :communities, :image, :string
  end
end
