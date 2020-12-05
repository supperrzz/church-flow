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
    @subscription = if @subscription_profile.present? && @subscription_profile.stripe_subscription_id.present?
                      response = Stripe::GetSubscription.call(stripe_subscription_id: @subscription_profile.stripe_subscription_id)
                      response.subscription
                    else
                      []
                    end
  end

  def create
    @card_id = nil
    if @subscription_profile.present? && @subscription_profile.stripe_customer_id.present?
      response = Stripe::CreateCard.call(stripe_customer_id: @subscription_profile.stripe_customer_id,
                                         token: params[:token])
      if response.error
        flash[:error] = response.error.message || 'Card add failed.'
      else
        @card_id = response.card.id
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
          @card_id = response_card.card.id
          flash[:success] = 'Added card.'
        end
      end
    end
    if @subscription_profile.stripe_card_id.blank? && @card_id.present?
      @subscription_profile.update(stripe_card_id: @card_id)
    end
    redirect_to admin_payment_methods_path
  end

  def default
    @subscription_profile.update stripe_card_id: params[:id]
    if @subscription_profile.active
      Stripe::ChangeSubscriptionCard.call(
        stripe_subscription_id: @subscription_profile.stripe_subscription_id,
        stripe_card_id: @subscription_profile.stripe_card_id
      )
    end
    redirect_back(fallback_location: admin_payment_methods_path)
  end

  def destroy
    if @subscription_profile.stripe_card_id != params[:id]
      response = Stripe::DeleteCard.call(stripe_customer_id: @subscription_profile.stripe_customer_id,
                                         card_id: params[:id])
      if response.error
        flash[:error] = response.error.message || 'Deletion failed.'
      else
        flash[:success] = 'Deleted card.'
      end
    else
      flash[:error] = 'Your card is being used in subscription.'
    end
    redirect_back(fallback_location: admin_payment_methods_path)
  end

  private

  def load_subscription_profile
    @subscription_profile = current_user.subscription_profile
  end
end
