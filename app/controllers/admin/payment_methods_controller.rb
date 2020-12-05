# frozen_string_literal: true

class Admin::PaymentMethodsController < ApplicationController
  layout 'admin'
  before_action :load_subscription_profile

  def index
    @cards = if @subscription_profile.present? && @subscription_profile.stripe_customer_id.present?
               response = Stripe::GetCards.call(stripe_customer_id: @subscription_profile.stripe_customer_id)
               response.cards.data
             else
               []
             end
  end

  def create
    if @subscription_profile.present? && @subscription_profile.stripe_customer_id.present?
      response = Stripe::CreateCard.call(stripe_customer_id: @subscription_profile.stripe_customer_id,
                                         token: params[:token])
      if response.error
        flash[:error] = response.error.message || 'Card add failed.'
      else
        flash[:success] = 'Added card.'
      end
    else
      response = Stripe::CreateUser.call(user: current_user)
      if response.error
        flash[:error] = response.error.message || 'Stripe user not created.'
      else
        if @subscription_profile.present?
          @subscription_profile.update(stripe_customer_id: response.customer.id)
        else
          @subscription_profile = SubscriptionProfile.create(user: current_user, stripe_customer_id: response.customer.id)
        end
        response_card = Stripe::CreateCard.call(stripe_customer_id: @subscription_profile.stripe_customer_id,
                                               token: params[:token])
        if response_card.error
          flash[:error] = response_card.error.message || 'Card add failed.'
        else
          flash[:success] = 'Added card.'
        end
      end
    end
    redirect_back(fallback_location: admin_payment_methods_path)
  end

  def delete
    if @subscription_profile.stripe_card_id != params[:card_id]
      response = Stripe::DeleteCard.call(stripe_customer_id: @subscription_profile.stripe_customer_id,
                                         card_id: params[:card_id])
      if response.error
        flash[:error] = response.error.message || 'Deletion failed.'
      else
        flash[:success] = 'Deleted card.'
      end
    else
      flash[:error] = 'Your card is being used in subscription.'
    end
    redirect_back(fallback_location: client_project_status_path)
  end

  private

  def load_subscription_profile
    @subscription_profile = current_user.subscription_profile
  end
end
