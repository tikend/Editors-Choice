class Userpost < ActiveRecord::Migration
  def up
    create_table :userposts do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
  end

  def down
    drop_table :userposts
  end
  end
end
