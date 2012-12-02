class AddPromotionToNews < ActiveRecord::Migration
  def change
    add_column :news, :is_promotion, :boolean, :default => false
  end
end
