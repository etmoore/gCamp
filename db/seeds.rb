Task.delete_all

30.times do
  Task.create description: Faker::Lorem.sentence,
              complete: [true, false, false, false].sample,
              due: Faker::Time.forward(21)
end
