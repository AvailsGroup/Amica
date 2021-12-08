class ChangeUseridAddNotnullOnAchievement < ActiveRecord::Migration[6.1]
  def change
    change_column_null :achievements,:userid,false
  end
end
