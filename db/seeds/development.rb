10_000.times do
  user=User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password
  )
  user.save!
end

10.times do
  bus_list=BusList.new(
    name: Faker::Educator.unique.university
  )
  bus_list.save!
end

