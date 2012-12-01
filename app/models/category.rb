class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :source
  has_many :news

  def self.find_by_source_name(source, category_name)
    categories = Category.where(:source_id => source, :name => category_name)
    categories[0]
  end
end
