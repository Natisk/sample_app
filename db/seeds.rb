User.transaction do
  # Users
  User.create!(name:  'Admin Admin',
               email: 'admin@admin.com',
               password:              'admin_',
               admin:     true,
               confirmed_at: Time.zone.now)

  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@fox_on_rails.com"
    password = 'password'
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 confirmed_at: Time.zone.now)
  end

  # Microposts
  users = User.order(:confirmed_at).take(6)
  20.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
  end

  # Following relationships
  # users = User.all
  # user  = users.first
  # following = users[2..50]
  # followers = users[3..40]
  # following.each { |followed| user.follow(followed) }
  # followers.each { |follower| follower.follow(user) }
end