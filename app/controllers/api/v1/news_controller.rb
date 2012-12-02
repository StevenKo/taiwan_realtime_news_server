class Api::V1::NewsController < Api::ApiController
  def index
    category_id = params[:category_id]
    @news = News.by_release_date_desc.category_news(category_id).paginate(:page => params[:page], :per_page => 15)
    # render :json => news.to_json
  end

  def show
    @news = News.select('id,source_id,title,release_time,content,category_id').find(params[:id])
    @pics = Picture.select('link,description').find_all_by_news_id(@news.id)
  end

  def promotion
    source_id = params[:source_id]
    @news = News.includes(:pictures).promotion_news(source_id)
  end
end