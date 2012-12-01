# encoding: utf-8
class EconomicCrawler
  include Crawler

  def get_news_page_link
    nodes = @page_html.css("select option")
    nodes.each do |node|
      url = "http://edn.udn.com/" + node[:value]
      crawler = EconomicCrawler.new
      crawler.fetch url
      crawler.get_news_list
    end
  end

  def get_news_list
    nodes = @page_html.css("tr td a")
    nodes.each do |node|
      if (node[:href].index("view.jsp?")) && !(node[:href].index("http"))
        url = "http://edn.udn.com/news/" + node[:href]
        crawler = EconomicCrawler.new
        crawler.fetch url
        crawler.parse_news
      end
    end
  end

  def parse_news
    title = @page_html.css(".title_4").text.strip
    
    # puts title
    nodes = @page_html.css("td")
    release_time = ""
    nodes.each do |node|
      time = node.text
      if /(\d\d\d\d\/\d\d\/\d\d \d\d:\d\d)/ =~ time
        release_time = DateTime.strptime($1, "%Y/%m/%d %H:%M")
        break
      end
    end

    puts title
    puts release_time
    

    nodes = @page_html.css("td")
    content = ""
    nodes.each do |node|
      text = node.text
      if /經濟日報記者/ =~ text
        content = text.strip
      end
    end
    puts content

    # release_time = DateTime.strptime($1, "%Y-%m-%d")

    # content = @page_html.css(".article").to_html
    # content = content.gsub("<br>","\n")    
    # n = Nokogiri::HTML(content)
    # content = n.text
    # # puts content

    category_name = @page_html.css(".title_1").text.strip
    category = Category.find_by_source_name(5,category_name)
    unless category
      category = Category.new
      category.source_id = 5
      category.name = category_name
      category.save
    end

    newses = News.where(["title like ?", "%#{title[0..6]}%"])
    (newses.present?) ? news = newses[0] : news = News.new
    news.source_id = 5
    news.title = title
    news.content = content
    news.release_time = release_time
    news.category = category
    news.save

    # news.pictures.each{|p| p.delete }

    # img_nodes = @page_html.css(".photoBox img")
    # text_nodes = @page_html.css(".photoBox p")
    # img_nodes.each_with_index do |node,i|
    #   p = Picture.new
    #   p.description = text_nodes[i].text.strip if text_nodes.size > i
    #   p.link = node[:src]
    #   p.news = news
    #   p.save
    # end

  end

end
