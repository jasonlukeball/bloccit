require 'random_data'
# Decided to use Faker instead

Post.find_or_create_by(title: "Unique Post Title", body: "Unique Post Body")

50.times do
  Post.create!(
        title:  Faker::Hipster.sentence,
        body:   Faker::Hipster.paragraph
  )
end

posts = Post.all

100.times do
  Comment.create!(
           post: posts.sample,
           body: Faker::Hipster.paragraph
  )
end

puts "DB Seed Finished!"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"