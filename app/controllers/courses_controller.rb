class CoursesController < ApplicationController
  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @courses = Article::Course.order("created_at desc").paginate page: @page, per_page: Settings.pagination.articles
  end

  def show
    @course = Article::Course.find params[:id]
  end
end
