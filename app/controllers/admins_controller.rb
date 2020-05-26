class AdminsController < ApplicationController
  before_action :set_admin, only: %i[show edit update destroy]

  def index
    @admins = User.where(role: :admin)
    authorize @admins
  end

  def new
    @admin = User.new
    authorize @admin
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      redirect_to admin_path(@admin), notice: 'Admin was successfully updated.'
    else
      render :edit, error: @admin.error.full_messages.first
    end
  end

  def create
    @admin = User.new role: :admin, password: SecureRandom.hex
    authorize @admin
    @admin.email = params[:user][:email]
    @admin.fname = params[:user][:fname]
    @admin.lname = params[:user][:lname]
    @admin.skip_confirmation!
    if @admin.save
      @admin.create_invitation_token
      flash[:notice] = 'Invitation Sent'
      redirect_to admins_path
    else
      flash.now[:error] = @admin.errors.full_messages.first
      render :new
    end
  end

  def destroy
    @admin.destroy
    redirect_to admins_url, notice: 'Admin was successfully destroyed.'
  end

  private

  def set_admin
    @admin = User.find(params[:id])
  end

  def admin_params
    params.require(:user).permit(:email, :fname, :lname)
  end
end
