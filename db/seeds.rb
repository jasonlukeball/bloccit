require 'random_data'
# Decided to use Faker instead



# users
# -------------------

admin   = User.create!(name: "Admin User", email: "admin@example.com", password: "password", role: 'admin')
member  = User.create!(name: "Member User", email: "member@example.com", password: "password", role: 'member')

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
         name: Faker::Hipster.sentence,
         description: Faker::Hipster.paragraph
  )
end

topics = Topic.all


# posts
# -------------------

Post.find_or_create_by(title: "Unique Post Title", body: "Unique Post Body")

50.times do
  Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
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



# comments
# -------------------

100.times do
  Comment.create!(
           post: posts.sample,
           body: Faker::Hipster.paragraph
  )
end


# advertisements
# -------------------

50.times do
  Advertisement.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, price: rand(0..100))
end

50.times do
  Question.create!(title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph, resolved: rand(0..1))
end


puts "DB Seed Finished!"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"