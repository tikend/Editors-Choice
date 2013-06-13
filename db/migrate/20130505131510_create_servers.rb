class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.text :url
      t.string :name

      t.timestamps
    end
  end
end
