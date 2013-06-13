class Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :posttags
  has_many :microposts, :through => :posttags
  has_many :tagcategories
  has_many :categories, :through => :tagcategories
end
