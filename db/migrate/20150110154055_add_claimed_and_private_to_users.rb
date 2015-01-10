class AddClaimedAndPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :claimed, :boolean
    add_column :users, :private, :string
  end
end
