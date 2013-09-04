class Characteristic < ActiveRecord::Base
  belongs_to :category
  attr_accessible :default_values, :input_kind, :name, :category_id,:default_values_attributes
  has_many :advertisement_characteristics
  validates :name, :presence => true, :uniqueness => {:scope => :category_id }
  belongs_to :advertisement
  has_many :default_values
  accepts_nested_attributes_for :default_values, :allow_destroy => true


  def self.search(search)
    if search
      where('name LIKE ?',"%#{search}%")
    else
      scoped
    end
  end

end
