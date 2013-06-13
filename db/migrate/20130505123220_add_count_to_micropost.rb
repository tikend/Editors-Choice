class AddCountToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :count, :int
    add_column :microposts, :serer_id, :int
  end
end
