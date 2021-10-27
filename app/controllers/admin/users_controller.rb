class Admin::UsersController < ApplicationController
  before_action :is_admin?

  def index
    @users = User.last(100)
  end
end
