class ChangeIconOfCommunity < ActiveRecord::Migration[6.1]
  def change
    def up
      add_column :communities, :icon, :string, default: nil
    end

    def down
      add_column :communities, :icon, :text
    end
  end
end
