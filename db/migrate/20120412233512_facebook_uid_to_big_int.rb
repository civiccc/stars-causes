class FacebookUidToBigInt < ActiveRecord::Migration
  def self.up
    change_column :users, :facebook_uid, :numeric, :precision => 0
  end

  def self.down
    change_column :users, :facebook_uid, :integer
  end
end
