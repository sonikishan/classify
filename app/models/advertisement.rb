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
  has_many :advertisement_statuses
  has_many :contacts


  letsrate_rateable "ratings"

  attr_accessible :advertisement_status_id, :deleted, :paid, 
                  :price, :title, :values_xml, :user_id, :category_id, :image,:advertisement_images_attributes,:approved,:advertisement_characteristics_attributes,:max_price,:min_price
  
  #has_attached_file :image

  validates :title, presence: true
  validates :price, presence: true
  validates :values_xml, presence: true
  validates :category_id, presence: true
  accepts_nested_attributes_for :advertisement_characteristics, :allow_destroy => true
  accepts_nested_attributes_for :advertisement_images, :allow_destroy => true
  

end
