class AddUserIdToClaims < ActiveRecord::Migration
  def change
  end
  add_reference :claims, :user, index: true
end
