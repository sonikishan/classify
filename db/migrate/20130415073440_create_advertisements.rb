class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.integer :price
      t.text :values_xml
      t.integer :advertisement_status_id
      t.boolean :paid
      t.boolean :deleted
      t.references :user
      t.references :category

      t.timestamps
    end
    add_index :advertisements, :user_id
    add_index :advertisements, :category_id
  end
end
