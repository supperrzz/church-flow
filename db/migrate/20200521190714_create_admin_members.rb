class CreateAdminMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_members do |t|
      t.string :fname
      t.string :lname
      t.belongs_to :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
