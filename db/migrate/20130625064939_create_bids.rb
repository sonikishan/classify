class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :price
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.references :user
      t.references :advertisement

      t.timestamps
    end
    add_index :bids, :user_id
    add_index :bids, :advertisement_id
  end
end
