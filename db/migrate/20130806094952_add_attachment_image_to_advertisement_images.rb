class AddAttachmentImageToAdvertisementImages < ActiveRecord::Migration
  def self.up
    change_table :advertisement_images do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :advertisement_images, :image
  end
end
