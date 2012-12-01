# encoding: utf-8
class ChinaTimeCrawler
  include Crawler

  def get_news_page_link
    get_news_list
    # nodes = @page_html.css(".Pagerbar a")
    # nodes.each do |node|
    #   if /\d/ =~ node.text
    #     url = node[:href]
    #     crawler = FreeCrawler.new
    #     crawler.fetch url
    #     crawler.get_news_list
    #   end
    # end
  end

  def get_news_list
    nodes = @page_html.css("a")
    nodes.each do |node|
      if node[:href].index("content.aspx")
        url = "http://m.chinatimes.com/" + node[:href]
        # puts url
        crawler = ChinaTimeCrawler.new
        crawler.fetch url
        crawler.parse_news
      end
    end
  end

  def parse_news
    title = @page_html.css(".mainR.newsContent h1").text.strip
    return if title.index("徵稿")
    # puts title
    time = @page_html.css(".author").text
    /(\d\d\d\d-\d\d-\d\d)/ =~ time
    release_time = DateTime.strptime($1, "%Y-%m-%d")

    content = @page_html.css(".article").to_html
    content = content.gsub("<br>","\n")    
    n = Nokogiri::HTML(content)
    content = n.text
    # puts content

    category_name = @page_html.css(".point.on").text.strip
    puts category_name
    category = Category.find_by_source_name(4,category_name)
    unless category
      category = Category.new
      category.source_id = 4
      category.name = category_name
      category.save
    end

    newses = News.where(["title like ?", "%#{title[0..6]}%"])
    (newses.present?) ? news = newses[0] : news = News.new
    news.source_id = 4
    news.title = title
    news.content = content
    news.release_time = release_time
    news.category = category
    news.save

    news.pictures.each{|p| p.delete }

    img_nodes = @page_html.css(".photoBox img")
    text_nodes = @page_html.css(".photoBox p")
    img_nodes.each_with_index do |node,i|
      p = Picture.new
      p.description = text_nodes[i].text.strip if text_nodes.size > i
      p.link = node[:src]
      p.news = news
      p.save
    end

  end

end
