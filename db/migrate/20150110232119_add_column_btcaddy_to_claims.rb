class AddColumnBtcaddyToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :btcaddy, :string
  end
end
