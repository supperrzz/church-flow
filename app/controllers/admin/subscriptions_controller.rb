class Admin::SubscriptionsController < ApplicationController
  layout 'admin'
  before_action :load_subscription_profile

  def index
    @subscriptions = Subscription.active.order(:rank)
  end

  def choose
    if @subscription_profile.present? && @subscription_profile.stripe_card_id.present?
      subscription = Subscription.find(params[:id])
      response = Stripe::CreateSubscription.call(
        stripe_customer_id: @subscription_profile.stripe_customer_id,
        stripe_card_id: @subscription_profile.stripe_card_id,
        stripe_price_id: subscription.stripe_price_id
      )
      if response.error
        flash[:error] = response.message || 'Subscription selection failed.'
      else
        flash[:notice] = 'Subscription successful.'
        @subscription_profile.update stripe_subscription_id: response.subscription.id,
                                     stripe_item_id: response.subscription.items.data[0].id,
                                     subscription_id: subscription.id,
                                     active: true
      end
      redirect_to admin_payment_methods_path
    else
      flash[:error] = 'No cards added yet. Please'
      redirect_to new_admin_payment_method_path
    end
  end

  def cancel
    response = Stripe::CancelSubscription.call(stripe_subscription_id: @subscription_profile.stripe_subscription_id)
    if response.error
      flash[:error] = response.message || 'Subscription selection failed.'
    else
      flash[:notice] = 'Subscription cancelled.'
    end
    redirect_to admin_payment_methods_path
  end

  private

  def load_subscription_profile
    @subscription_profile = current_user.subscription_profile
  end
end
