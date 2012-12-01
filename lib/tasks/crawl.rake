# encoding: utf-8
namespace :crawl do

  desc "Craw Website Item"

  task :crawl_apple_news => :environment do
    url = "http://www.appledaily.com.tw/realtimenews"
    crawler = AppleCrawler.new
    crawler.fetch url
    crawler.get_realtime_news_link
  end

  task :crawl_free_news => :environment do
    urls = {
      "政治" => "/liveNews/list.php?type=%E6%94%BF%E6%B2%BB",
      "社會" => "/liveNews/list.php?type=%E7%A4%BE%E6%9C%83",
      "科技" => "/liveNews/list.php?type=%E7%A7%91%E6%8A%80",
      "國際" => "/liveNews/list.php?type=%E5%9C%8B%E9%9A%9B",
      "財經" => "/liveNews/list.php?type=%E8%B2%A1%E7%B6%93",
      "生活" => "/liveNews/list.php?type=%E7%94%9F%E6%B4%BB",
      "體育" => "/liveNews/list.php?type=%E9%AB%94%E8%82%B2",
      "影劇" => "/liveNews/list.php?type=%E5%BD%B1%E5%8A%87",
      "趣聞" => "/liveNews/list.php?type=%E8%B6%A3%E8%81%9E"
    }

    urls.each do |type, url|
      crawl = FreeCrawler.new
      crawl.fetch url
      crawl.get_news_page_link
    end
  end

  task :crawl_union_news => :environment do
    urls = {
      "要聞" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS1",
      "社會" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS2",
      "地方" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS3",
      "兩岸" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS4",
      "國際" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS5",
      "財經" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS6",
      "運動" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS7",
      "娛樂" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS8",
      "生活" => "http://m.udn.com/xhtml/ViewCateFree?cate=0&cateDir=BREAKINGNEWS9"
    }

    urls.each do |type,url|
      crawl = UnionCrawler.new
      crawl.fetch url
      crawl.get_news_page_link
    end
  end

  task :crawl_chinatime_news => :environment do
    urls = {
      "焦點" => "http://m.chinatimes.com/list.aspx?cid=1",
      "政治" => "http://m.chinatimes.com/list.aspx?cid=2",
      "財經" => "http://m.chinatimes.com/list.aspx?cid=1212",
      "股市" => "http://m.chinatimes.com/list.aspx?cid=1203",
      "兩岸" => "http://m.chinatimes.com/list.aspx?cid=5",
      "國際" => "http://m.chinatimes.com/list.aspx?cid=4",
      "社會" => "http://m.chinatimes.com/list.aspx?cid=3",
      "地方" => "http://m.chinatimes.com/list.aspx?cid=6",
      "娛樂" => "http://m.chinatimes.com/list.aspx?cid=11",
      "樂活" => "http://m.chinatimes.com/list.aspx?cid=18",
      "科技" => "http://m.chinatimes.com/list.aspx?cid=9",
      "運動" => "http://m.chinatimes.com/list.aspx?cid=12",
      "藝文" => "http://m.chinatimes.com/list.aspx?cid=13",
      "論壇" => "http://m.chinatimes.com/list.aspx?cid=14"
    }

    urls.each do |type,url|
      crawl = ChinaTimeCrawler.new
      crawl.fetch url
      crawl.get_news_page_link
    end
  end

  task :crawl_economy_news => :environment do
    url = "http://edn.udn.com/news/category.jsp?cid=47"
    crawl = EconomicCrawler.new
    crawl.fetch url
    crawl.get_news_page_link
  end

end
