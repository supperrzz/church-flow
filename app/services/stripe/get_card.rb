# frozen_string_literal: true

class Stripe::GetCard
  include Interactor

  def call
    user = context.user
    context.card = Stripe::Customer.retrieve_source(
      user.stripe_id,
      context.card_id,
    )
  rescue StandardError => e
    context.fail!(error: e)
  end
end
