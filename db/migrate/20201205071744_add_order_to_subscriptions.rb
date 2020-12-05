class AddOrderToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :rank, :integer
  end
end
