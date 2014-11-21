Task.delete_all
User.delete_all

# 100.times do
#   Task.create description: Faker::Lorem.sentence,
#               complete: [true, false, false, false].sample,
#               due: Faker::Time.forward(21)
# end

30.times do
  first_name = Faker::Name.first_name
  User.create first_name: first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.safe_email(first_name)

end
