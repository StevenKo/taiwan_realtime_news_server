# encoding: utf-8
class FreeCrawler
  include Crawler
  require 'net/http'

  def get_news_page_link
    get_news_list
    nodes = @page_html.css("#page a")
    nodes.each do |node|
      if /\d/ =~ node.text
        url = node[:href]
        crawler = FreeCrawler.new
        crawler.fetch url
        crawler.get_news_list
      end
    end
  end

  def get_news_list
    nodes = @page_html.css("tbody.list a")
    nodes.each do |node|
      url = "/liveNews/" + node[:href]
      time = node.parent.parent.css(".listtime").text
      crawler = FreeCrawler.new
      crawler.fetch url
      crawler.parse_news time
    end
  end

  def parse_news time
    title = @page_html.css("#newsti").text
    index = /【(.*)】/ =~ title
    title = title[0..index-2]
    puts title
    release_time = DateTime.strptime(time, "%Y-%m-%d %H:%M")
    # puts release_time
    # puts title
    content = @page_html.css(".news_content").to_html
    content = content.gsub("<br>","\n")
    content = content[0..index-2] if index = (/<b>.*<\/b>/ =~ content)
    
    n = Nokogiri::HTML(content)
    content = n.text
    puts content

    category_name = @page_html.css(".news_kind").text.strip
    category = Category.find_by_source_name(2,category_name)
    unless category
      category = Category.new
      category.source_id = 2
      category.name = category_name
      category.save
    end

    newses = News.where(["title like ?", "%#{title[0..6]}%"])
    (newses.present?) ? news = newses[0] : news = News.new
    news.source_id = 2
    news.title = title
    news.content = content
    news.release_time = release_time
    news.category = category
    news.save

    news.pictures.each{|p| p.delete }

    img_nodes = @page_html.css(".pic_area img")
    text_nodes = @page_html.css(".pic_area .pic_text")
    img_nodes.each_with_index do |node,i|
      p = Picture.new
      p.description = text_nodes[i].text.strip if text_nodes.size > i
      p.link = "http://iservice.libertytimes.com.tw/Upload/" + node[:src]
      p.news = news
      p.save
    end

  end

  def get_page path
    http = Net::HTTP.new('iservice.libertytimes.com.tw', 80)
    if /\?type=(.*)\&/ =~ path
      query_str = {:q => $1}.to_query.gsub("q=","")
      path.gsub!("$1",query_str)
    end
    res = http.get path, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19', 'Cookie' => '_ts_id=360435043104370F39'
    content = res.body
    doc = Nokogiri::HTML(content)

  end

end
