collection @news
attributes :id, :title

node(:release_time) { |news| news.release_time.strftime "%Y/%m/%d %H:%M"}
node(:pic_link){|news| news.pictures[0].link if news.pictures.present? }