class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer :year
      t.integer :class
      t.integer :number
      t.integer :studentid
      t.text :introduction
      t.text :department
      t.timestamps
    end
  end
end
