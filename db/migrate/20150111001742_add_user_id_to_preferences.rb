class AddUserIdToPreferences < ActiveRecord::Migration
  def change
  	add_column :preferences, :user_id, :integer
  	add_index :preferences, :user_id
  end
end