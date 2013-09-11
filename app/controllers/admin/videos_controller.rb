class Admin::VideosController < Admin::BaseController
  before_filter :load_video, only: [:edit, :update, :destroy]

  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @videos = Video.order("created_at desc").paginate page: @page, per_page: Settings.pagination.videos
  end

  def destroy
    if @video.try :destroy
      redirect_to admin_videos_path, notice: "Video has been destroyed successfully"
    else
      redirect_to admin_videos_path, notice: "Video has not been destroyed successfully"
    end
  end

  def edit
  end

  def update
    if @video.update video_params
      redirect_to edit_admin_video_path(@video), notice: "Video was updated successfully"
    else
      redirect_to edit_admin_video_path(@video), notice: "Video was not updated successfully"
    end
  end

  private
  def load_video
    @video = Video.find params[:id]
  end

  def video_params
    params.require(:video).permit(:title, :url)
  end
end
