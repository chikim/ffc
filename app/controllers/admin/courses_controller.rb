class Admin::CoursesController < Admin::BaseController
  before_filter :load_course, only: [:edit, :update, :destroy]

  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @courses = Article::Course.order("created_at desc").paginate page: @page, per_page: Settings.pagination.articles
  end

  def destroy
    if @course.try :destroy
      redirect_to admin_courses_path, notice: "Course has been destroyed successfully"
    else
      redirect_to admin_courses_path, notice: "Course has not been destroyed successfully"
    end
  end

  def edit
  end

  def update
    if @course.update course_params
      redirect_to edit_admin_course_path(@course), notice: "Course was updated successfully"
    else
      redirect_to edit_admin_course_path(@course), notice: "Course was not updated successfully"
    end
  end

  def new
    @course = Article::Course.new
  end

  def create
    @course = Article::Course.new(course_params)
    if @course.save
      redirect_to edit_admin_course_path(@course), notice: "Course was created successfully"
    else
      render :new
    end
  end

  private
  def load_course
    @course = Article::Course.find params[:id]
  end

  def course_params
    params.require(:article_course).permit(:title, :short_description, :content)
  end
end
