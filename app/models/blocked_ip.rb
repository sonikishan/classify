class BlockedIp < ActiveRecord::Base
  attr_accessible :ip_address, :user_id
  belongs_to :user
end
