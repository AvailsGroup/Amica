class ChangeImageOfUser < ActiveRecord::Migration[6.1]
  def change
    def up
      add_column :users, :image, :string, default: nil
    end

    def down
      add_column :users, :image, :string
    end
  end
end
