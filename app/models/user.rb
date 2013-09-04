class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
   :salutation, :name, :address, :zipcode, :city, :province, :phone, :url, :longitude, :latitude,:role,:account_active,:block_ip
  # attr_accessible :title, :body
  has_many :advertisements, :through => :bids
  has_many :favorites
  has_many :abuse_reports
  has_many :bids
  has_many :blocked_ip
  has_many :authentications, :dependent => :delete_all
 
  def active_for_authentication?
    super && account_active?
  end
  
  def super_user?
     self.role == "Moderator"
  end
  def user?
     self.role == "user"
  end
  def admin?
    self.role == "admin" 
  end
  def self.search(search)
    if search
      where('name LIKE ? or email LIKE ?',"%#{search}%","%#{search}%")
    else
      scoped
    end
  end
  letsrate_rater


  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = auth['extra']['raw_info']['email']
    self.confirmed_at = Time.now
    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
end
