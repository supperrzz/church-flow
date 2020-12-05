# frozen_string_literal: true

class Stripe::GetSubscription
  include Interactor

  def call
    context.subscription = Stripe::Subscription.retrieve(context.stripe_subscription_id)
  rescue StandardError => e
    context.fail!(error: e)
  end
end
