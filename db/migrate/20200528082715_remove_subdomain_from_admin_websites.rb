class RemoveSubdomainFromAdminWebsites < ActiveRecord::Migration[6.0]
  def change
    remove_column :admin_websites, :subdomain, :string
  end
end
