# encoding: utf-8
class AppleCrawler
  include Crawler

  # def get_web_page url
  #   if /\/(\d*)\/(\d*)\/(.*)/ =~ url
  #     url = url[0..(url.length-$3.length-1)] + {:q => $3}.to_query.gsub("q=","") 
  #   end
  #   body = ''
  #   begin
  #     open(url){ |io|
  #         body = io.read
  #     }
  #   rescue
  #   end
  #   doc = Nokogiri::HTML(body)

  # end

  def get_realtime_news_link
    nodes = @page_html.css(".page_switch a")
    nodes.each do |node|
      if /\d/ =~ node.text
        url = "http://www.appledaily.com.tw/" + node[:href]
        crawler = AppleCrawler.new
        crawler.fetch url
        crawler.get_news_list
      end
    end
  end

  def get_news_list
    nodes = @page_html.css(".rtddt")
    nodes.each_with_index do |node, i|
      news = News.new
      category_name = node.css("h2").text.strip
      category = Category.find_by_source_name(1,category_name)
      unless category
        category = Category.new
        category.source_id = 1
        category.name = category_name
        category.save
      end
      news.category = category
      news.source_id = 1
      url = "http://www.appledaily.com.tw" + node.css("a")[0][:href]
      puts url
      crawler = AppleCrawler.new
      crawler.fetch url
      crawler.get_news news
    end
  end

  def get_news news
    node = @page_html.css("article.mpatc")
    title = node.css("h1").text
    content = node.css("#summary").to_html
    content = content.gsub("<br>","\n")
    n = Nokogiri::HTML(content)
    content = n.text
    
    newses = News.where(["title like ?", "%#{title[0..6]}%"])
    news = newses[0] if newses.present?
    news.title = title
    news.content = content
    time = node.css("time")[0].text
    news.release_time = DateTime.strptime(time, "%Y年%m月%d日%H:%M")
    news.save
    
    news.pictures.each{|p| p.delete }

    img_nodes = node.css("img")
    text_nodes = node.css(".textbox")
    img_nodes.each_with_index do |node,i|
      p = Picture.new
      p.description = text_nodes[i].text.strip
      p.link = node[:src]
      p.news = news
      p.save
    end
  end
end
