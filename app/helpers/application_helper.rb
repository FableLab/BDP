module ApplicationHelper

  def is_admin?
    if current_user and current_user.admin
      true
    else
      redirect_to root_path
    end
  end
end
