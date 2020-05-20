class SettingsController < ApplicationController
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
end
