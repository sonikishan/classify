class CreateAdvertisementImages < ActiveRecord::Migration
  def change
    create_table :advertisement_images do |t|
      t.integer :advertisement_id
      t.string :image

      t.timestamps
    end
  end
end
