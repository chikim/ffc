class TrainersController < ApplicationController
  def index
    @page = (params[:page] || Settings.pagination.default_first_page).to_i
    @trainers = Trainer.paginate page: @page, per_page: Settings.pagination.trainers
  end

  def show
    @trainer = Trainer.find_by id: params[:id]
  end
end
