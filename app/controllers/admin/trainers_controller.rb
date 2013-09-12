class Admin::TrainersController < Admin::BaseController
  before_filter :load_trainer, only: [:edit, :update, :destroy]

  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @trainers = Trainer.order("created_at desc").paginate page: @page, per_page: Settings.pagination.trainers
  end

  def destroy
    if @trainer.try :destroy
      redirect_to admin_trainers_path, notice: "Trainer has been destroyed successfully"
    else
      redirect_to admin_trainers_path, notice: "Trainer has not been destroyed successfully"
    end
  end

  def edit
  end

  def update
    if @trainer.update trainer_params
      redirect_to edit_admin_trainer_path(@trainer), notice: "Trainer was updated successfully"
    else
      redirect_to edit_admin_trainer_path(@trainer), notice: "Trainer was not updated successfully"
    end
  end

  def new
    @trainer = Trainer.new
  end

  def create
    @trainer = Trainer.new(trainer_params)
    if @trainer.save
      redirect_to edit_admin_trainer_path(@trainer), notice: "Trainer was created successfully"
    else
      render :new
    end
  end

  private
  def load_trainer
    @trainer = Trainer.find params[:id]
  end

  def trainer_params
    params.require(:trainer).permit(:name, :position, :self_introduction, :bio, :profile_picture)
  end
end
