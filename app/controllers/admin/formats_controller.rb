class Admin::FormatsController < ApplicationController
  before_action :is_admin?
  before_action :find_format, only: [:show, :edit, :update]

  def index
    @pagy, @formats = pagy(Format, items: 30)
  end

  def show
  end

  def edit
  end

  def update
    if @format.update format_params
      redirect_to admin_format_path(@format)
    else
      render :edit
    end
  end

  def new
    @format = Format.new
  end

  def create
    @format = Format.new(format_params)
    if @format.save
      redirect_to admin_format_path(@format)
    else
      render :new
    end
  end

  private

  def find_format
    @format = Format.find(params[:id])
  end

  def format_params
    params.require(:format).permit(:name, :code, :group)
  end
end
