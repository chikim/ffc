class GalleriesController < ApplicationController
  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @galleries = Gallery.paginate page: @page, per_page: Settings.pagination.galleries
  end

  def show
    @gallery = Gallery.find_by id: params[:id]
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @photos = @gallery.photos.paginate page: @page, per_page: Settings.pagination.photos
  end
end
