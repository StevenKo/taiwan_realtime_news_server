class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.integer :source_id
      t.string :title
      t.text :content
      t.datetime :release_time
      t.integer :category_id

      t.timestamps
    end
    add_index :news, :source_id
    add_index :news, :category_id
  end
end
