class ChangeMicropostTable < ActiveRecord::Migration
  def change
    change_table :microposts do |t|
      
      t.remove :content
      t.string :url
      t.string :author
      t.string :title
      t.string :picture
      t.string :description
    end
  end
end
