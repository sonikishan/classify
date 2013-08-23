class RemoveImageFromAdvertisementImage < ActiveRecord::Migration
  def up
    remove_column :advertisement_images, :image
  end

  def down
    add_column :advertisement_images, :image, :string
  end
end
