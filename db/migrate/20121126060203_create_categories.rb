class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :source_id

      t.timestamps
    end
    add_index :categories, :source_id
  end
end
