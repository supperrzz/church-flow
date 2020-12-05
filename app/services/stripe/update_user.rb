# frozen_string_literal: true

class Stripe::UpdateUser
  include Interactor

  def call
    user = context.user
    if user.stripe_id.present?
      Stripe::Customer.update(
        user.stripe_id,
        {
          email: user.email,
          name: user.name,
          metadata: { id: user.id }
        }
      )
    else
      ::Stripe::CreateUser.call(user: user)
    end
  rescue StandardError => e
    context.fail!(error: e)
  end
end
