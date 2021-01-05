# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: "george.kettle@icloud.com", password: 'secret', password_confirmation: 'secret')

locations = [
  {
    address: "Albany, Western Australia, Australia",
    longitude: 117.8836,
    latitude: -35.0248,
  },
  {
    address: "North Cottesloe Beach, Marine Pde, Perth, Western Australia 6011, Australia",
    longitude: 115.752588,
    latitude: -31.986299,
  },
  {
    address: "Cottesloe Beach Hotel, 104 Marine Parade, Perth, Western Australia 6011, Australia",
    longitude: 115.752425,
    latitude: -31.9946195,
  },
  {
    address: "Scarborough Beach, The Esplanade, Perth, Western Australia 6019, Australia",
    longitude: 115.7546845,
    latitude: -31.894164500000002,
  },
  {
    address: "Peasholm Street Dog Beach, West Coast Hwy, Perth, Western Australia 6019, Australia",
    longitude: 115.757887,
    latitude: -31.907672,
  },
  {
    address: "Brighton Beach, The Esplanade, Perth, Western Australia 6019, Australia",
    longitude: 115.755268,
    latitude: -31.901417,
  }
]

p "Creating locations"
locations.each do |location|
  Location.create!(
      address: location[:address],
      longitude: location[:longitude],
      latitude: location[:latitude],
    )
end
p "Finish creating locations"

# photos = [
#   {
#     address: "Albany, Western Australia, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133350/seeds/albany.jpg",
#     cloudinary_id: "albany"
#   },
#   {
#     address: "North Cottesloe Beach, Marine Pde, Perth, Western Australia 6011, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133365/seeds/north_cottesloe.jpg",
#     cloudinary_id: "north_cottesloe"
#   },
#   {
#     address: "North Cottesloe Beach, Marine Pde, Perth, Western Australia 6011, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133354/seeds/north_cottesloe_2.jpg",
#     cloudinary_id: "north_cottesloe_2"
#   },
#   {
#     address: "Cottesloe Beach Hotel, 104 Marine Parade, Perth, Western Australia 6011, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133528/seeds/cottesloe.jpg",
#     cloudinary_id: "cottesloe"
#   },
#   {
#     address: "Scarborough Beach, The Esplanade, Perth, Western Australia 6019, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133354/seeds/scarborough_beach.jpg",
#     cloudinary_id: "scarborough_beach"
#   },
#   {
#     address: "Scarborough Beach, The Esplanade, Perth, Western Australia 6019, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609134026/seeds/scarborough_2.jpg",
#     cloudinary_id: "scarborough_2"
#   },
#   {
#     address: "Peasholm Street Dog Beach, West Coast Hwy, Perth, Western Australia 6019, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133340/seeds/peasholm.jpg",
#     cloudinary_id: "peasholm"
#   },
#   {
#     address: "Brighton Beach, The Esplanade, Perth, Western Australia 6019, Australia",
#     url: "https://res.cloudinary.com/dur0bga45/image/upload/v1609133337/seeds/brighton_beach.jpg",
#     cloudinary_id: "brighton_beach"
#   },
# ]

# p "Creating photos"
#   photos.each do |photo|
#     new_photo = Photo.create!
#     new_photo.image.attach(io: File.open('app/assets/images/signup.jpeg'), filename: 'signup.png', content_type: 'image/png')
#   end
# p "Finish creating photos"

boards = [
  {
    title: "Scarborough WA",
    user_id: 1
  },
  {
    title: "Cottesloe Beach",
    user_id: 1
  },
  {
    title: "Australia",
    user_id: 1
  }
]

p "Creating boards"
boards.each do |board|
  b = Board.create!(
      title: board[:title],
    )
  BoardUser.create!(
      board_id: b.id,
      user_id: board[:user_id]
    )
end
p "Finish creating boards"

# BoardUser(user_id: integer, board_id: integer)

posts = [
  {
    title: "Albany beach",
    description: "Couldn't have asked for a better day out",
    user_id: 1,
    board_id: 3,
    photo_id: 1,
    location_id: 1
  },
  {
    title: "North Cottesloe Beach",
    description: "Just outside of Perth, absolutely gorgeous spot",
    user_id: 1,
    board_id: 2,
    photo_id: 2,
    location_id: 2
  },
  {
    title: "10 mins from Perth",
    description: "Wow, that's all I can say",
    user_id: 1,
    board_id: 3,
    photo_id: 2,
    location_id: 2
  },
  {
    title: "Best beach in Australia",
    description: "Cottesloe I love you",
    user_id: 1,
    board_id: 3,
    photo_id: 3,
    location_id: 3
  },
  {
    title: "Cottesloe Beach Hotel",
    description: "Some good memories here",
    user_id: 1,
    board_id: 2,
    photo_id: 4,
    location_id: 3
  },
  {
    title: "Scarborough Beach",
    description: "Sunshine lovin'",
    user_id: 1,
    board_id: 1,
    photo_id: 5,
    location_id: 4
  },
  {
    title: "Scarborough Beach at it's finest",
    description: "Give me some of that summer",
    user_id: 1,
    board_id: 1,
    photo_id: 6,
    location_id: 4
  },
  {
    title: "Peasholm Beach near Scarborough",
    description: "Do the beaches get any better than this?",
    user_id: 1,
    board_id: 1,
    photo_id: 7,
    location_id: 5
  },
  {
    title: "Brighton Beach WA",
    description: "Wow, how good is this.",
    user_id: 1,
    board_id: 1,
    photo_id: 8,
    location_id: 6
  },
]

p "Creating posts"
posts.each do |post|
  new_post = Post.new(
      title: post[:title],
      description: post[:description],
      user_id: post[:user_id],
      board_id: post[:board_id],
      user_id: post[:user_id],
      location_id: post[:location_id],
    )
  new_post.photo = Photo.new
  new_post.photo.image.attach(io: File.open('app/assets/images/signup.jpeg'), filename: 'signup.png', content_type: 'image/png')
  new_post.save!
end
p "Finish creating posts"
