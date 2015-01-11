class AddUploadColumnToClaims < ActiveRecord::Migration
  def self.up
    add_attachment :claims, :upload
  end

  def self.down
    remove_attachment :claims, :upload
  end
end
