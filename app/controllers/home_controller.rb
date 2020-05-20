class HomeController < ApplicationController
  def index
    if current_user
      if current_user.super_admin?
        @admins = User.where(role: :admin)
        render 'admins/index'
      elsif current_user.admin?
        redirect_to admin_my_church_path
      end
    end
  end
end
