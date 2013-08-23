class CreateViewCounts < ActiveRecord::Migration
  def change
    create_table :view_counts do |t|
      t.integer :amount
      t.references :advertisement

      t.timestamps
    end
    add_index :view_counts, :advertisement_id
  end
end
