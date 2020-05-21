class Admin::AdminBaseController < ApplicationController
  before_action :authenticate_user!, :check_admin

  private

  def check_admin
    return if current_user.admin? && current_user.invitation_completed
    flash[:error] = 'Access Denied.'
    redirect_to root_path
  end
end