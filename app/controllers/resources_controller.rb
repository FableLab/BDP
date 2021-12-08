class ResourcesController < ApplicationController
  #before_action :find_resource, only: [:show]

  def index
    @resource = Resource.new resource_params
    @pagy, @resources = pagy(Resource.order(created_at: :desc).where(resource_params), items: 12)
  end

  def show
    code_number = params[:slug].split('-')[4]
    @resource = Resource.find_by_code_number(code_number)
  end

  private

  def find_resource
    #@resource = Resource.find(params[:id])
  end

  def resource_params
    if params[:resource]
      params.require(:resource).permit(:projet_id, :category_id, :label_id, :format_id, :code_language).reject{|_, v| v.blank?}
    end
  end
end
