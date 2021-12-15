class CreateOpertationMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :opertation_messages do |t|
      t.text :message

      t.timestamps
    end
  end
end
