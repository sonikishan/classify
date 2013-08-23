class AddBlockuserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :block_user, :boolean, :default => false
  end
end
