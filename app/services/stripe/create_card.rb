# frozen_string_literal: true

class Stripe::CreateCard
  include Interactor

  def call
    card = Stripe::Customer.create_source(
      context.stripe_customer_id,
      { source: context.token },
    )
    context.card = card
  rescue StandardError => e
    context.fail!(error: e)
  end
end
