class Admin::UsersController < ApplicationController
  before_action :is_admin?
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @users = pagy(User, items: 30)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @user.delete
      redirect_to admin_users_path
    else
      render :show
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
end
