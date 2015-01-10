class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.string :key
      t.string :secret

      t.timestamps null: false
    end
  end
end
