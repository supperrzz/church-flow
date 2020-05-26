class SettingsController < ApplicationController
  before_action :authenticate_user!

  def profile
  end

  def save_profile
    if current_user.update(params.require(:user).permit(:profile_picture, :fname, :lname, :email))
      flash[:success] = 'Profile saved.'
      redirect_to settings_profile_path
    else
      flash.now[:error] = current_user.error.full_messages.first
      render 'settings/profile'
    end
  end

  def destroy
    if current_user.admin?
      user = current_user
      sign_out current_user
      flash[:notice] = 'Account deleted successfully.'
      user.destroy
    else
      flash[:error] = 'Operation not allowed.'
    end
    redirect_to root_path
  end
end
