class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :grade, default:"学科"
      t.integer :school_class, default: 0
      t.integer :number, default: 0
      t.integer :student_id, default: 0
      t.text :accreditation, default: "ここに所持資格を入力"
      t.text :hobby, default: "ここに趣味を入力"
      t.text :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
