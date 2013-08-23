class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :advertisement
  attr_accessible :confirmation_token, :confirmed_at, :price
  attr_accessible :user_id, :advertisement_id
end
