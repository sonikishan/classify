class Contact < ActiveRecord::Base
  attr_accessible :advertisement_id, :email, :message, :phone
  belongs_to :advertisement
end
