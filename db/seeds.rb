User.delete_all

30.times do
  first_name = Faker::Name.first_name
  password = Faker::Internet.password
  User.create first_name: first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.safe_email(first_name),
              password: password,
              password_confirmation: password

end
