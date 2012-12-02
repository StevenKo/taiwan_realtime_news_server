object @news
attributes :id,:title,:category_id

node(:pics){|news| news.pictures}