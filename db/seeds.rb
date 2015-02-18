# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


50.times do
 User.create(
  username: Faker::Internet.user_name,
  email: Faker::Internet.email,
  password: 'password',
  wins: rand(100),
  losses: rand(100),
  forfeits: rand(20),
  level: rand(4),
  experience: rand(1000),
  division: ['Champions League', 'junior A\'s', 'Junior B\'s', 'Minor'].sample(1).first)
end

User.all.each do |user|
  UserProfile.create(user_id: user.id,
                     first_name: Faker::Name.first_name,
                     last_name: Faker::Name.last_name,
                     country: Faker::Address.country,
                     bitcoin_address: Faker::Bitcoin.address,
                     card_type: Faker::Business.credit_card_type,
                     expirey_date: Faker::Business.credit_card_expiry_date,
                     card_number_last_four: Faker::Business.credit_card_number[-4..-1],
                     favorite_color: Faker::Commerce.color,
                     blog: Faker::Internet.url)
end


def random_player
  User.find(User.pluck(:id).sample)
end


25.times do |x|
  player1 = random_player
  player2 = random_player
  game = Game.new()
  game.users = [player1, player2]
  x.even? ? game.winner_id = player1.id : game.winner_id = player2.id
  game.save
end

User.all.sample(25).each do |user|
  Game.create(users: [user])
end



User.create(username: 'EliasMaus' , password: 'password', email: 'EliasMaus@aol.com')
User.create(username: 'MLamson' , password: 'password', email: 'MLamson@aol.com')
User.create(username: 'mollietaylor' , password: 'password', email: 'mollietaylor@aol.com')
User.create(username: 'nickray22' , password: 'password', email: 'nickray22@aol.com')
User.create(username: 'NRHCowarT' , password: 'password', email: 'NRHCowarT@aol.com')
User.create(username: 'spencerwyckoff' , password: 'password', email: 'spencerwyckoff@aol.com')
User.create(username: 'Will16' , password: 'password', email: 'Will16@aol.com')
User.create(username: 'williammasonjones' , password: 'password', email: 'williammasonjones@aol.com')
User.create(username: 'brossetti1' , password: 'password', email: 'brossetti17@aol.com')
User.create(username: 'redline6561' , password: 'password', email: 'redline6561@aol.com')


















