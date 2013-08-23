class AddAttachmentImageToAdvertisements < ActiveRecord::Migration
  def self.up
    change_table :advertisements do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :advertisements, :image
  end
end
