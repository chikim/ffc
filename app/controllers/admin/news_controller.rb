class Admin::NewsController < Admin::BaseController
  before_filter :load_news, only: [:edit, :update, :destroy]

  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @all_news = Article::News.order("created_at desc").paginate page: @page, per_page: Settings.pagination.articles
  end

  def destroy
    if @news.try :destroy
      redirect_to admin_news_index_path, notice: "News has been destroyed successfully"
    else
      redirect_to admin_news_index_path, notice: "News has not been destroyed successfully"
    end
  end

  def edit
  end

  def update
    if @news.update news_params
      redirect_to edit_admin_news_path(@news), notice: "News was updated successfully"
    else
      redirect_to edit_admin_news_path(@news), notice: "News was not updated successfully"
    end
  end

  def new
    @news = Article::News.new
  end

  def create
    @news = Article::News.new(news_params)
    if @news.save
      redirect_to edit_admin_news_path(@news), notice: "News was created successfully"
    else
      render :new
    end
  end

  private
  def load_news
    @news = Article::News.find params[:id]
  end

  def news_params
    params.require(:article_news).permit(:title, :short_description, :content, :cover_image)
  end
end
