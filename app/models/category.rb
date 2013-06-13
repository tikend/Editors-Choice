class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tagcategories
  has_many :tags, :through => :tagcategories

end
