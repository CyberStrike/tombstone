class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :email
      t.string :status
      t.string :keyone
      t.string :keytwo

      t.timestamps null: false
    end
  end
end
