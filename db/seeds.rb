# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying all users"
User.destroy_all

puts "Creating Christian..."

User.create(first_name: "Christian", 
            last_name: "Carey", 
            email: "christian@example.com",
            password: "password",
            password_confirmation: "password")


puts "Creating other users..."
20.times do 
  first_name = Faker::Name.first_name
  User.create(first_name: first_name, 
            last_name: Faker::Name.last_name, 
            email: Faker::Internet.email(first_name),
            password: "password",
            password_confirmation: "password")
end

puts "Filling out profiles and making posts..."

User.all.each do |user|
  p = user.profile
  p.birthday         = Faker::Date.backward(20_000)
  p.college          = Faker::University.name
  p.hometown         = Faker::Address.city
  p.current_location = Faker::Address.city
  p.phone            = Faker::PhoneNumber.phone_number
  p.about_me         = Faker::Lorem.paragraph(2)
  p.tagline          = Faker::Lorem.sentence(1)
  p.save

  rand(10..20).times do
    user.posts.build(content: Faker::Lorem.sentence(2))
  end

  user.save
end

puts "Commenting on and liking posts"

Post.all.each_with_index do |post, index|
  rand(0..8).times do 
    post.comments.build(content:   Faker::Lorem.sentence(1),
                        author_id: User.all.sample.id)
  end

  unless index % 4 == 0
    rand(1..4).times do 
      post.likers << User.all.sample
    end
  end

  post.save
end

puts "Liking comments"

Comment.all.each_with_index do |comment, index|
  if index % 4 == 0
    comment.likers << User.all.sample
  end
end
