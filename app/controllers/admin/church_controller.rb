class Admin::ChurchController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def show
    @church = current_user.church
  end

  def edit
    @church = current_user.church
  end

  def update
    @church = current_user.church
    if @church.update(church_params)
      flash[:notice] = 'Update successful'
      redirect_to admin_my_church_path
    else
      flash.now[:error] = @church.errors.full_messages.first
      render 'admin/church/edit'
    end
  end

  private

  def check_admin
    return if current_user.admin? && current_user.invitation_completed
    flash[:error] = 'Access Denied.'
    redirect_to root_path
  end

  def church_params
    params.require(:church).permit(
      :logo,
      :name,
      :address,
      :phone_number,
      :fb,
      :youtube,
      :instagram,
      :give_link
    )
  end
end
