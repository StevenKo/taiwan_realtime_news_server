class News < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category
  belongs_to :source
  has_many :pictures
  scope :by_release_date_desc, order('release_time DESC')
  scope :category_news, lambda { |category| where('category_id = (?)', category).select('id,title,release_time') }
end
