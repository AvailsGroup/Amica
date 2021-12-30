class AddIntroToProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :intro, :text
  end
end
