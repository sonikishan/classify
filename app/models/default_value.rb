class DefaultValue < ActiveRecord::Base
  attr_accessible :characteristic_id, :default_value
  belongs_to :characteristic
  has_many :advertisment_characteristics
end
