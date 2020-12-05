# frozen_string_literal: true

class Stripe::ChangeSubscription
  include Interactor

  def call
    subscription = Stripe::Subscription.update(
      context.stripe_subscription_id,
      {
        items: [
          {
            id: context.stripe_item_id,
            price: context.stripe_price_id
          }
        ]
      }
    )
    context.subscription = subscription
  rescue StandardError => e
    context.fail!(error: e)
  end
end
