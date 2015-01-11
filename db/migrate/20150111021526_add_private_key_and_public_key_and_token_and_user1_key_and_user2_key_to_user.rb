class AddPrivateKeyAndPublicKeyAndTokenAndUser1KeyAndUser2KeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :private_key, :string
    add_column :users, :public_key, :string
    add_column :users, :token, :string
    add_column :users, :user1_key, :string
    add_column :users, :user2_key, :string
  end
end
