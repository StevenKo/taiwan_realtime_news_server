class News < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category
  belongs_to :source
  has_many :pictures
end
