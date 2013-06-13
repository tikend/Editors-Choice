class Micropost < ActiveRecord::Base
  attr_accessible :url, :users, :tags, :category
  
  has_many :userposts
  has_many :users, :through => :userposts
  belongs_to :server
  has_many :posttags
  has_many :tags, :through => :posttags
  
  VALID_URL_REGEX =  /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates :url, presence: true, format: { with: VALID_URL_REGEX }
  validates :title, presence: true

  default_scope order: 'microposts.created_at DESC'

  # def self.from_users_followed_by(user, category)
#       
        # find_by_sql ["select * from(select p.* from microposts p join userposts up on up.micropost_id = p.id
        # join users u on up.user_id = u.id
        # join posttags pt on pt.micropost_id = p.id
        # join tags t on t.id = pt.tag_id
        # join tagcategories tc on tc.tag_id = t.id
        # join categories c on c.id = tc.category_id
        # where u.id = ? and c.name = ? and age(p.created_at) < '2 days'
# 
        # union
# 
        # select p.*
        # from microposts p
        # join userposts up on up.micropost_id = p.id
        # join relationships r on up.user_id = r.followed_id
        # join posttags pt on pt.micropost_id = p.id
        # join tags t on t.id = pt.tag_id
        # join tagcategories tc on tc.tag_id = t.id
        # join categories c on c.id = tc.category_id
        # where r.follower_id = ? and c.name = ? and age(p.created_at) < '2 days'
        # ) i
        # order by i.count desc NULLS LAST, i.created_at desc
        # ", user.id, "#{category}", user.id, "#{category}"]
  # end
  
  def self.from_users_followed_by(user, category)
      
        find_by_sql ["select * from(select p.* from microposts p join userposts up on up.micropost_id = p.id
        join users u on up.user_id = u.id
        where u.id = ? and p.category ~ ? and age(p.created_at) < '2 days'

        union

        select p.*
        from microposts p
        join userposts up on up.micropost_id = p.id
        join relationships r on up.user_id = r.followed_id
        where r.follower_id = ? and p.category ~ ? and age(p.created_at) < '2 days'
        ) i
        order by i.count desc NULLS LAST, i.created_at desc
        ", user.id, "#{category}", user.id, "#{category}"]
  end
    
end
