class ViewCount < ActiveRecord::Base
  belongs_to :advertisement
  attr_accessible :amount, :advertisement_id
end
