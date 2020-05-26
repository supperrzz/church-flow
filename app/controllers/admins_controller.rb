class AdminsController < ApplicationController
  before_action :authenticate_user!, :check_super_admin

  def index
    @admins = User.where(role: :admin)
    authorize @admins
  end

  def new
    @admin = User.new
    authorize @admin
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

  end

  private

  def check_super_admin
    return if current_user.super_admin?
    flash[:notice] = 'Access denied'
    redirect_to root_path
  end
end
