require 'faker'

# Number of users and posts to create
NUM_USERS = 100
NUM_POSTS = 200_000
NUM_IPS = 50
RATING_PERCENTAGE = 0.75
THREAD_COUNT = [Etc.nprocessors * 2, 50].min

def ips
  @ips ||= NUM_IPS.times.map { Faker::Internet.ip_v4_address }.uniq
end

def usernames
  @usernames ||= NUM_USERS.times.map { |i| Faker::Internet.username}
end

def build_post
  {
    post: {
      title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph, login: usernames.sample , ip: ips.sample
    }
  }
end

def build_ratings(post)
  User.all.to_a.sample(rand(1..10)).map do |user|
    {
      user_id: user.id,
      post_id: post.id,
      value: rand(1..5)
    } unless post.user_id == user.id
  end.compact
end

def make_api_request(endpoint, params)
  url = "http://localhost:3000/api/v1/#{endpoint}"
  params_string = params.to_query
  `curl -X POST -d "#{params_string}" #{url}`
end

return if Post.exists?

threads = []

NUM_POSTS.times.each_slice(NUM_POSTS / THREAD_COUNT) do |slice|
  threads << Thread.new do
    slice.each { |index| make_api_request("posts", build_post) }
  end
end

threads.each(&:join)

threads = []
post_with_ratings_count = NUM_POSTS * RATING_PERCENTAGE

Post.all.limit(post_with_ratings_count).each_slice(post_with_ratings_count / THREAD_COUNT) do |post_slice|
  threads << Thread.new do
    post_slice.each do |post|
      build_ratings(post).each { |rating| make_api_request("posts/rate", rating) }
    end
  end
end

threads.each(&:join)
