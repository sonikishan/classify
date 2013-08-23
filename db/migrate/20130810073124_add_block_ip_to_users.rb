class AddBlockIpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :block_ip, :boolean, :default => false
  end
end
