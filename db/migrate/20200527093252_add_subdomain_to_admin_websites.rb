class AddSubdomainToAdminWebsites < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_websites, :subdomain, :string
  end
end
