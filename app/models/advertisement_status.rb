class AdvertisementStatus < ActiveRecord::Base
  attr_accessible :status
  has_many :advertisements
end
