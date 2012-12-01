class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.text :description
      t.string :link
      t.integer :news_id
      t.timestamps
    end
    add_index :pictures, :news_id
  end
end
