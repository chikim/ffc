class VideosController < ApplicationController
  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @videos = Video.paginate page: @page, per_page: Settings.pagination.videos
  end

  def show
    @video = Video.find params[:id]
  end
end
