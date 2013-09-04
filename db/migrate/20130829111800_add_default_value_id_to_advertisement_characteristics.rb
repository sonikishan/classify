class AddDefaultValueIdToAdvertisementCharacteristics < ActiveRecord::Migration
  def change
    add_column :advertisement_characteristics, :default_value_id, :integer
  end
end
