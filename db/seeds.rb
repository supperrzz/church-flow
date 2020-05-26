unless User.exists? role: :super_admin
  super_admin = User.create(
      fname: 'Super',
      lname: 'Admin',
      email: 'super@admin.com',
      password: '123456',
      role: :super_admin,
      invitation_completed: true)
  super_admin.skip_confirmation!
  super_admin.save
end