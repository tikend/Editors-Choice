class Tagcategory < ActiveRecord::Base
  attr_accessible :category_id, :tag_id
  
  belongs_to :tag
  belongs_to :category
end
