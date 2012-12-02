collection @news
attributes :id, :title

node(:release_time) { |news| news.release_time.strftime "%Y/%m/%d %H:%M" if news.release_time}