class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :tagcategories
  has_many :tags, :through => :tagcategories
  
  def self.find_non_empty
    find_by_sql ["select distinct * from (select name from categories
join microposts on categories.name = microposts.category
where age(microposts.created_at) < '2 days'
union
select category from microposts
where age(created_at) < '2 days') i order by i.name"]
  end

end
