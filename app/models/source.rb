class Source < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :categories
  has_many :news
end
