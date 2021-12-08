class Achievement < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|
      t.integer :user_id
      t.integer :communitiesCount
      t.integer :registrationDays
      t.integer :friendsCount
      t.integer :likesCount
      t.integer :commentsCount
      t.integer :birthdayMonth
      t.timestamps
    end
  end
end
