# encoding: utf-8
class UnionCrawler
  include Crawler

  def get_news_page_link
    str = @page_html.css(".navbar").text
    /(\d*)\/(\d*)/ =~ str
    (1..$2.to_i).each do |i|
      url = "#{@page_url}&page=#{i}"
      # puts url
      crawler = UnionCrawler.new
      crawler.fetch url
      crawler.get_news_list
    end
  end

  def get_news_list
    nodes = @page_html.css("a")
    nodes.each do |node|
      if node[:href].index("ViewFreeArticle?")
        url = "http://m.udn.com/xhtml/" + node[:href]
        crawler = UnionCrawler.new
        crawler.fetch url
        crawler.parse_news
      end
    end
  end

  def parse_news
    title = @page_html.css("#story_title").text
    puts title
    time_text = @page_html.css("#endShow").text
    time_text = time_text[time_text.index("即時報導:")+6..time_text.length]
    release_time = DateTime.strptime(time_text, "%Y-%m-%d %H:%M:%S")
    content = @page_html.css("#sp_body").to_html
    content = content.gsub("<p>","\n")
    n = Nokogiri::HTML(content)
    content = n.text.strip

    category_name = @page_html.css(".title").text.strip
    category = Category.find_by_source_name(3,category_name)
    unless category
      category = Category.new
      category.source_id = 3
      category.name = category_name
      category.save
    end

    newses = News.where(["title like ?", "%#{title[0..6]}%"])
    (newses.present?) ? news = newses[0] : news = News.new
    news.source_id = 3
    news.title = title
    news.content = content
    news.release_time = release_time
    news.category = category
    news.save


  end

end
