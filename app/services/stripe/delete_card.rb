# frozen_string_literal: true

class Stripe::DeleteCard
  include Interactor

  def call
    user = context.user
    Stripe::Customer.delete_source(
      user.stripe_id,
      context.card_id,
    )
  rescue StandardError => e
    context.fail!(error: e)
  end
end
