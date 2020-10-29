require 'faker'
Faker::Config.locale = :fr

Gossip.destroy_all
Tag.destroy_all
User.destroy_all
City.destroy_all
Comment.destroy_all
Like.destroy_all
PrivateMessage.destroy_all
JoinTableTagGossip.destroy_all
LierPrivateMessageUser.destroy_all

# Cities

1000.times do
  city_and_zip = Faker::Address.full_address.split(', ').last
  zip = city_and_zip.split(' ').first
  city_name = city_and_zip.split(' ').last
  next if City.find_by(name: city_name)

  City.create(name: city_name, zip_code: zip)
end
puts
puts 'Cities table'
tp City.all.limit(20)
# Users
adjectifs = %w[petit grand maigre gros chauve muscle intelligent parfait mediocre insupportable eblouissant valeureux]
10.times do
  first_name = Faker::Name.first_name
  age = rand(18..90)
  city = City.all.sample
  text = "Je m'appelle #{first_name}, je suis #{adjectifs.sample} et mon livre préféré est #{Faker::Book.title}, je suis #{Faker::Name.title[:job].sample} à #{city.name} "
  User.create(first_name: first_name, last_name: Faker::Name.last_name, description: text, email: Faker::Internet.email, age: age, city: city, password: 'abcdef')
end
puts
puts 'Users table'
tp User.all

# Gossips
20.times do
  Gossip.create(title: Faker::Hipster.word, content: Faker::ChuckNorris.fact, user: User.all.sample)
end
puts
puts 'Gossips table'
tp Gossip.all

# Tags
10.times do
  Tag.create(title: Faker::Verb.base)
end
puts
puts 'Tags table'
tp Tag.all

Tag.all.each do |t|
  JoinTableTagGossip.create(tag: t, gossip: Gossip.all.sample)
end

Gossip.all.each do |g|
  JoinTableTagGossip.create(tag: Tag.all.sample, gossip: g)
end

puts
puts 'JoinTableTagGossip table'
tp JoinTableTagGossip.all

# Private messages
10.times do
  PrivateMessage.create(content: Faker::Lorem.sentence, sender: User.all.sample)
end
puts
puts 'Private messages table'
tp PrivateMessage.all

# Lier private_messages_users
User.all.each do |u|
  LierPrivateMessageUser.create(user: u, private_message: PrivateMessage.all.sample)
end

PrivateMessage.all.each do |pm|
  LierPrivateMessageUser.create(user: User.all.sample, private_message: pm)
end

puts
puts 'Lier private message et users table'
tp LierPrivateMessageUser.all

# Comments
20.times do |_c|
  Comment.create(user: User.all.sample, gossip: Gossip.all.sample, content: Faker::Quote.famous_last_words)
end

puts
puts 'Comments'
tp Comment.all

# likes
20.times do |_l|
  rand_num = rand(1..2)
  if rand_num == 1
    Like.create(comment_id: Comment.all.sample.id, user: User.all.sample)
  else
    Like.create(gossip_id: Gossip.all.sample.id, user: User.all.sample)
  end
end

puts
puts 'Likes'
tp Like.all
