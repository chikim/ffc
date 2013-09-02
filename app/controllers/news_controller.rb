class NewsController < ApplicationController
  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @all_news = Article::News.order("created_at desc").paginate page: @page, per_page: Settings.pagination.articles
  end

  def show
    @news = Article::News.find_by id: params[:id]
  end
end
