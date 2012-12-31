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
    newses = []
    Category.all.each do |category|
      if category.id < 41
        news = by_release_date_desc.by_id_desc.find_all_by_category_id(category.id).first
        news.is_promotion = true
        newses << news
      end
    end
    newses.each{|news| news.save}
  end
end
