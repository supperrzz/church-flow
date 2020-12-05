module Admin::SubscriptionsHelper
  def get_upgrade_or_downgrade(subscription, subscription_profile)
    if subscription.rank > subscription_profile.subscription.rank
      'Upgrade'
    else
      'Downgrade'
    end
  end
end
