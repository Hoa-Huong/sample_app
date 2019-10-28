User.create!(name: "Hòa Thị Hường", email: "hoahuong@gmail.com",
  password: "foobar", password_confirmation: "foobar", admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "huong#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end
