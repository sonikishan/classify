class AdvertisementImage < ActiveRecord::Base
  attr_accessible :advertisement_id, :image
  belongs_to :advertisement
  has_attached_file :image
  validates :image, :attachment_presence => true
end
