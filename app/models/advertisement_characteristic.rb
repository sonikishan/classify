class AdvertisementCharacteristic < ActiveRecord::Base
  attr_accessible :advertisement_id, :characteristic_id, :value
  belongs_to :advetisement
  belongs_to :characteristic
end
