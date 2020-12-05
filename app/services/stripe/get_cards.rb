# frozen_string_literal: true

class Stripe::GetCards
  include Interactor

  def call
    json = { object: 'card', limit: 20 }
    context.cards = Stripe::Customer.list_sources(
      context.stripe_customer_id,
      json
    )
  rescue StandardError => e
    context.fail!(error: e)
  end
end
