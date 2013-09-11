class Admin::PhotosController < Admin::BaseController
  before_filter :load_gallery
  before_filter :load_photo, only: [:edit, :update, :destroy]

  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @photos = @gallery.photos.order("created_at desc").paginate page: @page, per_page: Settings.pagination.photos
  end

  def destroy
    if @photo.try :destroy
      redirect_to admin_gallery_photos_path(@gallery), notice: "Photo has been destroyed successfully"
    else
      redirect_to admin_gallery_photos_path(@gallery), notice: "Photo has not been destroyed successfully"
    end
  end

  def edit
  end

  def update
    if @photo.update photo_params
      redirect_to edit_admin_gallery_photo_path(@gallery, @photo), notice: "Photo was updated successfully"
    else
      redirect_to edit_admin_gallery_photo_path(@gallery, @photo), notice: "Photo was not updated successfully"
    end
  end

  private
  def load_gallery
    @gallery = Gallery.find params[:gallery_id]
  end

  def load_photo
    @photo = @gallery.photos.find params[:id]
  end

  def photo_params
    params.require(:photo).permit(:title, :image)
  end
end
