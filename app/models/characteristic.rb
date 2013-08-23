class Characteristic < ActiveRecord::Base
  belongs_to :category
  attr_accessible :default_values, :input_kind, :name, :category_id
  has_many :advertisement_characteristics
  belongs_to :advetisement
end
