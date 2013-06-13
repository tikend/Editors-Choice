class CreateTagcategories < ActiveRecord::Migration
  def change
    create_table :tagcategories do |t|
      t.integer :tag_id
      t.integer :category_id

      t.timestamps
    end
  end
end
