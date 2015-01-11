class AddUserIdToWallet < ActiveRecord::Migration
  def change
  end
  add_reference :wallets, :user, index: true
end
