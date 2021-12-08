class Admin::ResourcesController < ApplicationController
  before_action :is_admin?
  before_action :find_resource, only: [:show, :edit, :update]

  def index
    @pagy, @resources = pagy(Resource, items: 30)
  end

  def show
  end

  def edit
  end

  def update
    if @resource.update resource_params
      redirect_to resource_path(@resource.slug)
    else
      render :show
    end
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to resource_path(@resource.slug)
    else
      render :new
    end
  end

  private

  def find_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:projet_id, :label_id, :category_id, :format_id, :code_language, :code_number, :translation, :file).reject{|_, v| v.blank?}
  end
end
