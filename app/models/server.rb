class Server < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :microposts
end
