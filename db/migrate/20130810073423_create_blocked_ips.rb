class CreateBlockedIps < ActiveRecord::Migration
  def change
    create_table :blocked_ips do |t|
      t.integer :user_id
      t.string :ip_address

      t.timestamps
    end
  end
end
