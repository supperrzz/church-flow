# frozen_string_literal: true

class Stripe::CancelSubscription
  include Interactor

  def call
    subscription = Stripe::Subscription.update(
      context.stripe_subscription_id,
      {
        cancel_at_period_end: true
      }
    )
    context.subscription = subscription
  rescue StandardError => e
    context.fail!(error: e)
  end
end
