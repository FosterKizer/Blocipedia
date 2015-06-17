require 'faker'

#Create User's
10.times do
  user = User.new(
    name:    Faker::Name.name,
    email:   Faker::Internet.email,
    password:Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end
users = User.all

#Create Wiki's
50.times do
  Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.words,
    body:   Faker::Lorem.paragraph(6)
    )
end
wikis = Wiki.all

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  name:     'Foster',
  email:    'kizer713@gmail.com',
  password: 'Drummer13'
  )


puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"