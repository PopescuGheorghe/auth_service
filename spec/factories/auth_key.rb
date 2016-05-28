FactoryGirl.define do
  factory :auth_key do |f|
    f.token { Faker::Internet.password }
    f.token_created_at Time.now
  end
end
