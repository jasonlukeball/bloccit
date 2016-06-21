require 'random_data'


# users
# -------------------

admin     = User.create!(name: "Admin User", email: "admin@example.com", password: "password", role: 'admin')
member    = User.create!(name: "Member User", email: "member@example.com", password: "password", role: 'member')
moderator = User.create!(name: "Moderator User", email: "moderator@example.com", password: "password", role: 'moderator')

5.times do
  User.create!(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end

users = User.all


# topics
# -------------------

15.times do
  Topic.create!(
    user: admin,
    name: Faker::Hipster.sentence,
    description: Faker::Hipster.paragraph,
    public: [true, false].sample
  )
end

topics = Topic.all


# posts
# -------------------

Post.find_or_create_by(title: "Unique Post Title", body: "Unique Post Body")

50.times do
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
  post.update_attribute(:created_at, rand(10.minutes..1.year).ago)
  rand(1..5).times {post.votes.create!(value: [1, -1].sample, user: users.sample)}
end

posts = Post.all


# sponsored posts
# -------------------

SponsoredPost.find_or_create_by(title: "Unique Post Title", body: "Unique Post Body", price: 100)

50.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    price: rand(0..1000)
  )
end

sponsored_posts = SponsoredPost.all


# comments for posts
# -------------------

50.times do
  Comment.create!(
    user: users.sample,
    commentable: posts.sample,
    body: Faker::Hipster.paragraph

  )
end


# comments for topics
# -------------------

50.times do
  Comment.create!(
    user: users.sample,
    commentable: topics.sample,
    body: Faker::Hipster.paragraph

  )
end


# advertisements
# -------------------

50.times do
  Advertisement.create!(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    price: rand(0..100)
  )
end

50.times do
  Question.create!(
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph,
    resolved: rand(0..1)
  )
end

puts
puts "DB Seed Finished!"
puts "--------------------"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"
puts "#{Vote.count} votes created"