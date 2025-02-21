FactoryBot.define do
  factory :rating do
    post { create(:post) }
    user { create(:user) }
    value { (1..5).to_a.sample }
  end
end
