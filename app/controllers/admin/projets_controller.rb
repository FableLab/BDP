class Admin::ProjetsController < ApplicationController
  before_action :is_admin?
  before_action :find_projet, only: [:show, :edit, :update]

  def index
    @pagy, @projets = pagy(Projet.order(:slug), items: 30)
  end

  def show
  end

  def edit
  end

  def update
    if @projet.update projet_params
      redirect_to admin_projet_path(@projet)
    else
      render :edit
    end
  end

  def new
    @projet = Projet.new
  end

  def create
    @projet = Projet.new(projet_params)
    if @projet.save
      redirect_to admin_projet_path(@projet)
    else
      render :new
    end
  end

  private

  def find_projet
    @projet = Projet.find(params[:id])
  end

  def projet_params
    params.require(:projet).permit(:name, :description, :code)
  end
end
