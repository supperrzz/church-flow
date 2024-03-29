# frozen_string_literal: true

class Stripe::DeleteCard
  include Interactor

  def call
    Stripe::Customer.delete_source(
      context.stripe_customer_id,
      context.card_id,
    )
  rescue StandardError => e
    context.fail!(error: e)
  end
end
