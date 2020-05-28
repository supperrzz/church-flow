if User.exists? role: :super_admin
  puts 'Super Admin already present'
else
  super_admin = User.create(
    fname: 'Super',
    lname: 'Admin',
    email: 'super@admin.com',
    password: '123456',
    role: :super_admin,
    invitation_completed: true,
    subdomain: 'www',
    time_zone: ActiveSupport::TimeZone.all.first.name
  )
  super_admin.skip_confirmation!
  if super_admin.save
    puts 'Super Admin Created'
  else
    puts super_admin.errors.full_messages
  end
end