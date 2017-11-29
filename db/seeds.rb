# frozen_string_literal: true

User.transaction do
  # Users
  User.create!(
    name: 'Admin Admin',
    email: 'admin@admin.com',
    password: 'admin_',
    role: 'admin',
    confirmed_at: Time.zone.now
  )

  30.times do |n|
    name  = Faker::Name.name
    email = "example#{n+1}@foxrails.com"
    password = 'password'
    User.create!(
      name: name,
      email: email,
      password: password,
      confirmed_at: Time.zone.now
    )
  end

  # Microposts
  users = User.order(:confirmed_at).take(6)
  20.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end
