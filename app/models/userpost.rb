class Userpost < ActiveRecord::Base
  attr_accessible :user, :micropost, :user_id, :micropost_id
  
  belongs_to :user
  belongs_to :micropost
  
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  
  default_scope order: 'userposts.created_at DESC'
  
  def self.find_or_create_by_user_and_micropost(attributes)
    Userpost.where(attributes).first || Userpost.create(attributes)
  end
end