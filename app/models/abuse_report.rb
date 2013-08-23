class AbuseReport < ActiveRecord::Base
  belongs_to :user
  belongs_to :advertisement
  attr_accessible :message, :user_id, :advertisement_id, :pulldown
  scope :cheaper_than, lambda { |pulldown| where("pulldown > ? ", pulldown ) }
  
end
