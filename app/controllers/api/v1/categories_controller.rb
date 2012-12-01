class Api::V1::CategoriesController < Api::ApiController
  def index
    source_id = params[:source_id]
    categories = Category.select('id,name').find_all_by_source_id(source_id)
    render :json => categories.to_json
  end
end
