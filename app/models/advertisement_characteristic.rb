class AdvertisementCharacteristic < ActiveRecord::Base
  attr_accessible :advertisement_id, :characteristic_id, :value,:default_value_id
  belongs_to :advetisement
  belongs_to :characteristic
  belongs_to :default_value
end
