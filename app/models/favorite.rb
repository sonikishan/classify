class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :advertisement
  attr_accessible :advertisement_id, :user_id
end
