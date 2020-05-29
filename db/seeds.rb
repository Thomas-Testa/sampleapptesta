User.create!(username: "TESTA",
    email: "thomastesta1@gmail.com",
    password: "testa123",
    password_confirm: "testa123",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

99.times do |n| 
    name = Faker::Name.name
    email="example-#{n+1}@railstutorial.org"
    password="password"
    User.create!(username: name,email: email,password: password,password_confirm: password, activated: true,
        activated_at: Time.zone.now)
end