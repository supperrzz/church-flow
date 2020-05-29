# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_user
      if current_user.super_admin?
        @admins = User.where(role: :admin)
        render 'admins/index'
      elsif current_user.admin?
        if current_user.invitation_completed
          redirect_to admin_my_church_path
        else
          flash.clear
          flash.now[:error] = 'Invitation not accepted yet. Resending invitation now.'
          current_user.create_invitation_token
          sign_out current_user
        end
      end
      # else
      # new_user_session_path
    end
  end
end
