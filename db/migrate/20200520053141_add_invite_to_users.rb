class AddInviteToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invite_token, :string
    add_column :users, :invite_sent_at, :datetime
    add_column :users, :invitation_completed, :boolean, default: false
  end
end
