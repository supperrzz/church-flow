class AddStripeItemIdToSubscriptionProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :subscription_profiles, :stripe_item_id, :string
  end
end
