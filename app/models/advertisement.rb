class Advertisement < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :users, :through => :bids 
  has_one :view_count
  has_many :abuse_reports
  has_many :bids
  has_many :advertisement_characteristics
  has_many :characteristics
  has_many :advertisement_images
  belongs_to :advertisement_status
  has_many :contacts


  letsrate_rateable "ratings"

  attr_accessible :advertisement_status_id, :deleted, :paid, 
                  :price, :title, :values_xml, :user_id, :category_id, :image,:advertisement_images_attributes,:approved,:advertisement_characteristics_attributes,:max_price,:min_price, :name, :email, :phonenumber, :zipcode
  
  #has_attached_file :image
  attr_reader :maxprice, :minprice
  attr_writer :maxprice, :minprice
  validates :title, presence: true
  validates :price, presence: true
  validates_length_of :values_xml, :minimum => 10, :allow_blank => false
  validates :category_id, presence: true
  accepts_nested_attributes_for :advertisement_characteristics, :allow_destroy => true, :reject_if => lambda { |a| a[:value].blank? }
  accepts_nested_attributes_for :advertisement_images, :allow_destroy => true
  

  def self.search(search)
    if search
      where('title LIKE ?',"%#{search}%")
    else
      scoped
    end
  end

end
