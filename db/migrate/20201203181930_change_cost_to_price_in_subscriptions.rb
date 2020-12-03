class ChangeCostToPriceInSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_column :subscriptions, :cost, :float
    add_column :subscriptions, :price, :float
  end
end
