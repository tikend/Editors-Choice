class MicropostsLonger < ActiveRecord::Migration
  def self.up
    change_column :microposts, :url, :text
    change_column :microposts, :author, :text
    change_column :microposts, :title, :text
    change_column :microposts, :picture, :text
    change_column :microposts, :description, :text
  end

  def self.down
    # change_column :microposts, :url, :string
    # change_column :microposts, :author, :string
    # change_column :microposts, :title, :string
    # change_column :microposts, :picture, :string
    # change_column :microposts, :description, :string
  end
end
