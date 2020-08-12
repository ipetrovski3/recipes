2.times do
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              handle_name: Faker::Superhero.name,
              mail: Faker::Internet.unique.email,
              password: '123123',
              password_confirmation: '123123')
end

6.times do |i|
  recipe = Recipe.create(name: Faker::Food.dish,
                         user_id: 1,
                         instructions_attributes: [
                           { name: Faker::Food.metric_measurement },
                           { name: Faker::Food.metric_measurement },
                           { name: Faker::Food.metric_measurement },
                           { name: Faker::Food.metric_measurement },
                           { name: Faker::Food.metric_measurement }
                         ],
                         ingredients_attributes: [
                           { name: Faker::Food.ingredient },
                           { name: Faker::Food.ingredient },
                           { name: Faker::Food.ingredient },
                           { name: Faker::Food.ingredient },
                           { name: Faker::Food.ingredient }
                         ])
  recipe.image.attach(io: open('https://picsum.photos/1920/1080'), filename: "#{i}_recipe_image.jpg")
end

puts "You've successfully seeded the database"
