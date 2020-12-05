# frozen_string_literal: true

class Stripe::CreateSubscription
  include Interactor

  def call
    subscription = Stripe::Subscription.create(
      {
        customer: context.stripe_customer_id,
        items: [
          {
            price: context.stripe_price_id
          }
        ],
        default_payment_method: context.stripe_card_id
      }
    )
    context.subscription = subscription
  rescue StandardError => e
    context.fail!(error: e)
  end
end
