object @news
attributes :id,:source_id,:title,:content,:category_id

node(:release_time) { |news| news.release_time.strftime "%Y/%m/%d %H:%M"}
node(:pics){|news| @pics}