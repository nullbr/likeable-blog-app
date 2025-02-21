FactoryBot.define do
  factory :post do
    user { create(:user) }
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    ip { Faker::Internet.ip_v4_address }
  end
end
