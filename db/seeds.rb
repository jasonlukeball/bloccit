require 'random_data'
# Decided to use Faker instead



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
    topic: topics.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
end

posts = Post.all


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
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} advertisements created"
puts "#{Question.count} questions created"