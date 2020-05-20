class AdminsController < ApplicationController
  before_action :authenticate_user!

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
    if @admin.save
      flash[:notice] = 'Invitation Sent'
      redirect_to admins_path
    else
      flash.now[:error] = @admin.errors.full_messages.first
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end
end
