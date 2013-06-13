class Posttag < ActiveRecord::Base
  attr_accessible :tag_id, :micropost_id
  
  belongs_to :micropost
  belongs_to :tag
end
