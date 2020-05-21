class Admin::ChurchController < Admin::AdminBaseController

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
