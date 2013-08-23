class CreateAdvertisementCharacteristics < ActiveRecord::Migration
  def change
    create_table :advertisement_characteristics do |t|
      t.integer :advertisement_id
      t.integer :characteristic_id
      t.string :value

      t.timestamps
    end
  end
end
