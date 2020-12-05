# frozen_string_literal: true

class Stripe::CreateUser
  include Interactor

  def call
    user = context.user
    context.customer = Stripe::Customer.create(
      {
        email: user.email,
        name: "#{user.fname} #{user.lname}",
        metadata: { id: user.id }
      }
    )
  rescue StandardError => e
    context.fail!(error: e)
  end
end
