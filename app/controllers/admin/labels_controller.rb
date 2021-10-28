class Admin::LabelsController < ApplicationController
  before_action :is_admin?
  before_action :find_label, only: [:show, :edit, :update]

  def index
    @pagy, @labels = pagy(Label.order(:slug), items: 30)
  end

  def show
  end

  def edit
  end

  def update
    if @label.update label_params
      redirect_to admin_label_path(@label)
    else
      render :edit
    end
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_label_path(@label)
    else
      render :new
    end
  end

  private

  def find_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
