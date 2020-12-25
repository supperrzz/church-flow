class Admin::DashboardController < ApplicationController
  layout "admin"
  
  def index
    @subscription_profile = if current_user.subscription_profile.present?
                              current_user.subscription_profile
                            else
                              SubscriptionProfile.create(user: current_user)
                            end
  end
end
