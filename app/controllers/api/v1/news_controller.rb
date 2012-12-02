class Api::V1::NewsController < Api::ApiController
  def index
    category_id = params[:category_id]
    @news = News.by_release_date_desc.category_news(category_id).paginate(:page => params[:page], :per_page => 15)
    # render :json => news.to_json
  end

  def show
    news = News.select('id,source_id,title,release_time,content').find(params[:id])
    output = {}
    output["news"] = news
    output["pic"] = Picture.select('link,description').find_all_by_news_id(news.id)
    render :json => output.to_json
  end
end
