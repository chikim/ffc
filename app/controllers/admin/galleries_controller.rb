class Admin::GalleriesController < Admin::BaseController
  before_filter :load_gallery, only: [:edit, :update, :destroy]

  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @galleries = Gallery.order("created_at desc").paginate page: @page, per_page: Settings.pagination.galleries
  end

  def destroy
    if @gallery.try :destroy
      redirect_to admin_galleries_path, notice: "Gallery has been destroyed successfully"
    else
      redirect_to admin_galleries_path, notice: "Gallery has not been destroyed successfully"
    end
  end

  def edit
  end

  def update
    if @gallery.update gallery_params
      redirect_to edit_admin_gallery_path(@gallery), notice: "Gallery was updated successfully"
    else
      redirect_to edit_admin_gallery_path(@gallery), notice: "Gallery was not updated successfully"
    end
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      redirect_to edit_admin_gallery_path(@gallery), notice: "Gallery was created successfully"
    else
      render :new
    end
  end

  private
  def load_gallery
    @gallery = Gallery.find params[:id]
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @photos = @gallery.photos.paginate page: @page, per_page: Settings.pagination.photos
  end

  def gallery_params
    params.require(:gallery).permit(:title, :cover_photo_id)
  end
end
