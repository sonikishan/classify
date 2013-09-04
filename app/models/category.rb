class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id,:active_status
  acts_as_tree :order => 'name'

  # VALID_CHAR_REGEX = /^[a-zA-Z\s]*$/ format: { with: VALID_CHAR_REGEX }, 
  validates :name, presence: true, 
                   uniqueness: { case_sensitive: false },
                   length: { minimum: 2, maximum: 20 }
  has_many :characteristics
  has_many :advertisements

  def self.search(search)
    if search
      where('name LIKE ? ',"%#{search}%")
    else
      scoped
    end
  end
end
