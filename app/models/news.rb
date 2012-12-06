class News < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :category
  belongs_to :source
  has_many :pictures
  scope :by_release_date_desc, order('release_time DESC')
  scope :by_id_desc, order('id DESC')
  scope :category_news, lambda { |category| where('category_id = (?)', category).select('id,title,release_time') }
  scope :promotion_news, lambda { |source_id| where('source_id = (?) AND is_promotion = true', source_id).select('id,title,category_id') }
  
  def self.update_promote
    update_all(:is_promotion => false)
    (1..5).each do |source_id|
      ids = Category.select('id').find_all_by_source_id(source_id).map{|c| c.id}
      ids.each do |category_id|
        news = by_id_desc.by_release_date_desc.find_all_by_category_id(1).last
        news.is_promotion = true
        news.save
      end
    end
  end
end
