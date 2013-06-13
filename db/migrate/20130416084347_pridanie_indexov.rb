class PridanieIndexov < ActiveRecord::Migration
  def up
    add_index :userposts, [:micropost_id]
    add_index :microposts, [:created_at]
  #  add_index :relationships, [:followed_id]
    add_index :userposts, [:user_id]
  end

  def down
    remove_index :userposts, [:micropost_id]
    remove_index :microposts, [:created_at]
  #  remove_index :relationships, [:followed_id]
    remove_index :userposts, [:user_id]
  end
end
