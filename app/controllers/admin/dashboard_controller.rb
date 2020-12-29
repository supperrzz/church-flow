class Admin::DashboardController < ApplicationController
  layout "admin"
  
  def index
    @subscription_profile = if current_user.subscription_profile.present?
                              current_user.subscription_profile
                            else
                              SubscriptionProfile.create(user: current_user)
                            end
    @subscription = @subscription_profile.subscription
    start_time = Time.now.beginning_of_month
    end_time = Time.now.end_of_month
    query = current_user.admin_live_stream_stats.where(asset_created_at: [start_time, end_time])
    @asset_duration = query.sum(:asset_duration) / 3600.0
    delivered_seconds = query.sum(:delivered_seconds)
    @visitors = if @asset_duration != 0
                  delivered_seconds / @asset_duration
                else
                  0
                end
  end
end
