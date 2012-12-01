# encoding: utf-8
class CrawlWorker
  include Sidekiq::Worker
  
  def perform(url)

    if url.index('liveNews')
      crawl = FreeCrawler.new
      crawl.fetch url
      crawl.get_news_page_link
    elsif url.index('udn')
      crawl = UnionCrawler.new
      crawl.fetch url
      crawl.get_news_page_link
    elsif url.index('chinatimes')
      crawl = ChinaTimeCrawler.new
      crawl.fetch url
      crawl.get_news_page_link
    end 
    
  end
end