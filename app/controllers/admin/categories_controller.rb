class Admin::CategoriesController < ApplicationController
  before_action :is_admin?
  before_action :find_category, only: [:show, :edit, :update]

  def index
    @pagy, @categories = pagy(Category, items: 30)
  end

  def show
  end

  def edit
  end

  def update
    if @category.update category_params
      redirect_to admin_category_path(@category)
    else
      render :edit
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :code)
  end
end
